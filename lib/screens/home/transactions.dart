import 'package:client/helpers/headers.dart';

class AllTransactions extends StatefulWidget {
  static const String routeName = alltransactions;
  const AllTransactions({Key? key}) : super(key: key);

  @override
  _AllTransactionsState createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
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
                                text: "All Transactions",
                                isViewAll: false),
                            defaultDivider(),
                            mediumCustomSizedBox(context)
                          ],
                        ),
               ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return  Padding(
                            padding: const EdgeInsets.symmetric(vertical : 4.0),
                            child: ListTile(
                              tileColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: const BorderSide(
                                    color: kLavenderGrayColor, width: 0.5),
                              ),
                              leading: Image.asset(
                                'assets/images/profile.png',
                                height: 30,
                                width: 30,
                              ),
                              title: Text("SM Logistices",
                                  style: mediumTextStyle(context)),
                              subtitle: Text("Debited",
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