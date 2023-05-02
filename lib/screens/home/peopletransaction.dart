
import 'package:client/helpers/headers.dart';
import 'package:flutter/cupertino.dart';

class PeopleTransactionPage extends StatefulWidget {
  static const String routeName = peopletransactionpage;
  const PeopleTransactionPage({super.key});

  @override
  State<PeopleTransactionPage> createState() => _PeopleTransactionPageState();
}

class _PeopleTransactionPageState extends State<PeopleTransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonNavbar(context: context, isBack: true),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                                text: "Transactions History",
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
                              'https://images.unsplash.com/photo-1614283233556-f35b0c801ef1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c2lkZSUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80',
                              height: 30,
                              width: 30,
                            ),
                            title: Text("Aravind S",
                                style: mediumTextStyle(context)),
                            subtitle: Text("1234567890",
                                style: smallTextStyle(context)),
                            
                          ),
                        smallCustomSizedBox(context),
                        // kSmallDivider(context),
                        mediumCustomSizedBox(context),
                         
                         //bank accounts linked
                         ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 15,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: ListTile(
                                    tileColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side: const BorderSide(
                                          color: kLavenderGrayColor,
                                          width: 0.5),
                                    ),
                                    leading: Icon(
                                      CupertinoIcons.add_circled_solid,
                                      //Icons.do_not_disturb_on_total_silence_sharp,
                                      // color: kPinkRedishColor,
                                      color: kGreenColor,
                                    ),
                                    title: Text("Debited",
                                        style: mediumTextStyle(context)),
                                    subtitle: Text("25-06-2023 04:30am",
                                        style: smallTextStyle(context)),
                                    trailing: Text("-\$ 200.00",
                                        style: mediumTextStyle(context)),
                                  ),
                                );
                              }), 
                        
            ],
          ),
        ),
      ),
    );
  }
}