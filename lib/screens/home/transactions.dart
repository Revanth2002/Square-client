import 'package:client/apis/homeapi.dart';
import 'package:client/helpers/headers.dart';

class AllTransactions extends StatefulWidget {
  static const String routeName = alltransactions;
  const AllTransactions({Key? key}) : super(key: key);

  @override
  _AllTransactionsState createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {

  Future? _allTransactionsFuture;

  final HomeScreenAPI _homeScreenAPI = HomeScreenAPI();

  @override
  void initState() {
    super.initState();
    _allTransactionsFuture = _getAllTransactions();
  }

  _getAllTransactions() async {
    return await _homeScreenAPI.getAllTransactions(context: context);
  }

  Future<void> _getRefreshedHomeScreenData() async {
    setState(() {
      _allTransactionsFuture = _getAllTransactions();
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
          future: _allTransactionsFuture,
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
                                  text: "All Transactions",
                                  isViewAll: false),
                              defaultDivider(),
                              mediumCustomSizedBox(context)
                            ],
                          ),

                if(snapshot.data['transactions'].length == 0)
                  Center(child: Text("No Transactions",style: mediumTextStyle(context),)),

                 ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data['transactions'].length,
                          itemBuilder: (context, i) {
                            return  Padding(
                              padding: const EdgeInsets.symmetric(vertical : 4.0),
                              child: ListTile(
                                tileColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: const BorderSide(
                                      color: kLavenderGrayColor, width: 0.5),
                                ),
                                leading: Image.network(
                                  snapshot.data['transactions'][i]['img'],
                                  height: 30,
                                  width: 30,
                                  fit: BoxFit.cover,
                                  
                                ),
                                title: Text(snapshot.data['transactions'][i]['name'],
                                    style: mediumTextStyle(context)),
                                subtitle: Text(snapshot.data['transactions'][i]['own_pid'] ? "Deposit" : "Withdrawal",
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
        )
      ),
    );
  }
}