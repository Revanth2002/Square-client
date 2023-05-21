
import 'package:client/apis/homeapi.dart';
import 'package:client/helpers/headers.dart';
import 'package:client/screens/home/sendmoney.dart';
import 'package:client/screens/home/setuppin.dart';
import 'package:flutter/cupertino.dart';

class PeopleTransactionPage extends StatefulWidget {
  static const String routeName = peopletransactionpage;
  final String toPid;
  const PeopleTransactionPage({super.key, required this.toPid});

  @override
  State<PeopleTransactionPage> createState() => _PeopleTransactionPageState();
}

class _PeopleTransactionPageState extends State<PeopleTransactionPage> {

  Future? _peopleTransactionFuture;
  final HomeScreenAPI _homeScreenAPI = HomeScreenAPI();

  @override
  void initState() {
    super.initState();
    _peopleTransactionFuture = _getPeopleTransaction();
  }

  _getPeopleTransaction() async {
    return await _homeScreenAPI.getTransactionPeople(context: context, toPid: widget.toPid);
  }

  Future<void> _getRefreshedHomeScreenData() async {
    setState(() {
      _peopleTransactionFuture = _getPeopleTransaction();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = sizeMedia(context);
    return Scaffold(
      appBar: commonNavbar(context: context, isBack: true),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _getRefreshedHomeScreenData,
        color: kPrimaryColor,
        strokeWidth: 3,
        child: FutureBuilder(
          future: _peopleTransactionFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              return SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultScreenPaddingHorizontal(context),
              vertical: kDefaultScreenPaddingVertical(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            rowTitleText(
                                onTap: () {},
                                context: context,
                                isCapitalFont: false,
                                text: snapshot.data["to_pid"]['name'],
                                isViewAll: false),
                            defaultDivider(),
                            mediumCustomSizedBox(context)
                          ],
                        ),
               //people
                          ListTile(
                            onTap: () {},
                            tileColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: const BorderSide(
                                  color: Colors.white, width: 0.5),
                            ),
                            leading: Image.network(
                              snapshot.data["to_pid"]['img'],
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            ),
                            title: Text(snapshot.data["to_pid"]['email'],
                                style: mediumTextStyle(context)),
                            subtitle: Text(snapshot.data["to_pid"]['mobile'],
                                style: smallTextStyle(context)),
                            
                          ),
                        //Add the send money button
                        primaryBtn(
                          context: context,
                          btnText: "Send Money",
                          isOutline: true,
                          onTap: () {
                            if(snapshot.data["is_pin_set"] == false){
                              bottomDialog(
                                        context: context,
                                        height: 180,
                                        widget: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin:EdgeInsets.symmetric(horizontal: kDefaultScreenPaddingHorizontal(context) * 2,vertical: 5),
                                                
                                              child: Text("Transaction PIN is configured yet",style: mediumTextStyle(context))),
                                            smallCustomSizedBox(context),
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.pop(context);
                                                Navigator.push(
                                                context,
                                                CustomSimplePageRoute(
                                                    page: SetupPinPage(isPinSetup: snapshot.data["is_pin_set"]),
                                                    routeName: setuppin));
                                              },
                                              child: Container(
                                                height: 35, 
                                                margin:EdgeInsets.symmetric(horizontal: kDefaultScreenPaddingHorizontal(context) * 2,vertical: 5),
                                                decoration: BoxDecoration(
                                                  color : kWhiteSmoke,
                                                  //border: Border.all(color: kPrimaryColor),
                                                  borderRadius: BorderRadius.circular(3),
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Icon(Icons.add,color:Colors.black,size:15),
                                                      Text("Tap to Setup Pin",style: mediumTextStyle(context))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            /*
                                            Expanded(
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics: const AlwaysScrollableScrollPhysics(),
                                                  itemCount: 2,
                                                  addAutomaticKeepAlives: true,
                                                  itemBuilder: (BuildContext context, int i) {
                                                    return ListTile(
                                                      onTap: () {
                                                        // overlayLoader(context);
                                                        // print("-----------------------");
                                                        // print(_memberItem[i]['id'].toString());
                                                        //  changeBookingMember(memberID: _memberItem[i]['id'].toString());
                                                        },
                                                      leading : Icon(
                                                          Icons.radio_button_checked_outlined,
                                                          color: kPrimaryColor,
                                                        ),
                                                      title: Text("Setup", style: mediumTextStyle(context)),
                                                      trailing: const Icon(Icons.arrow_right),
                                                    );
                                                  }),
                                            ),*/
                                          ],
                                        ),
                                      );
                            }
                            else if (snapshot.data['card_enabled'] == false){
                              ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "You have not added any card or yet to be verified"));
                            }
                            else if (snapshot.data['to_pid']['card_enabled'] == false){
                              ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "The receiver has not added any card or yet to be verifie"));
                            }
                            else{
                              Navigator.push(
                                context,
                                CustomSimplePageRoute(
                                    page: SendMoneyPage(
                                      recPid: snapshot.data["to_pid"]['pid'],
                                      recName: snapshot.data["to_pid"]['name'],
                                      recImg: snapshot.data["to_pid"]['img'],
                                      recPhone: snapshot.data["to_pid"]['mobile'],
                                      ),
                                    routeName: sendmoneypage));
                            }
                          },
                          vertical: 15
                        ),
                        kSmallDivider(context),
                        mediumCustomSizedBox(context),
                         //bank accounts linked
                         ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data["transactions"].length,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: ListTile(
                                tileColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: const BorderSide(
                                      color: kLavenderGrayColor, width: 0.5),
                                ),
                                leading: Icon(
                                  snapshot.data['transactions'][i]['own_pid'] ? Icons.add_circle_outlined : Icons.remove_circle_outline,
                                  color: kPrimaryColor,
                                ),
                                title: Text(snapshot.data['transactions'][i]['own_pid'] ? "Deposit" : "Withdrawal",
                                    style: mediumTextStyle(context)),
                                subtitle: Text(snapshot.data['transactions'][i]['created_at'],
                                    style: smallTextStyle(context)),
                                trailing: Text("${snapshot.data['transactions'][i]['own_pid'] ? "+" : "-"} \u{20B9} ${snapshot.data['transactions'][i]['amount']}",
                                    style: mediumTextStyle(context)),
                              ),
                                );
                              }), 
                        
            ],
          ),
        ),
      );
            }else if (snapshot.hasError) {
                    return defaultErrordialog(
                        context: context,
                        errorCode: ES_0060,
                        message: "Something went wrong.Try again Later");
                  }
                  return SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Center(child: customCircularProgress()));
          },
        ),
      )
    );
  }
}