import 'package:client/helpers/headers.dart';

class SearchPeoplePage extends StatefulWidget {
  static const String routeName = searchpeoplepage;
  final bool isOneTimePop;
  const SearchPeoplePage({Key? key, required this.isOneTimePop})
      : super(key: key);

  @override
  _SearchPeoplePageState createState() => _SearchPeoplePageState();
}

class _SearchPeoplePageState extends State<SearchPeoplePage> {
  final TextEditingController _searchController = TextEditingController();

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonNavbar(context: context, isBack: true),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: kDefaultScreenPaddingHorizontal(context),
                  vertical: kDefaultScreenPaddingVertical(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  mediumCustomSizedBox(context),
                  Text(
                    "Send Money to your friends",
                    style: ultraLargeTextStyle(context)
                        .copyWith(fontFamily: kMuktaRegular),
                  ),
                  smallCustomSizedBox(context),
                  Text(
                    "Start searching now",
                    style:
                        mediumLargeTextStyle(context).copyWith(color: kDimGray
                            //fontFamily : kQuickSandBold
                            ),
                  ),
                  mediumCustomSizedBox(context),
                  smallCustomSizedBox(context),
                  DynamicSearch(
                      controller: _searchController,
                      performSearch: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                        // if(widget.isOneTimePop){
                        //   Navigator.of(context).pop();
                        // }else{
                        //  int count = 0;
                        //   Navigator.of(context).popUntil((_) => count++ >= 2);
                        // }
                        // Navigator.push(context, CustomRightPageRoute(page: DoctorsDisplayPage(
                        //       searchType: "first",
                        //       searchQuery: _searchController.text.trim(),
                        //       ), routeName: doctordisplay));
                      }),
                ],
              ),
            ),
            smallCustomSizedBox(context),
            kSmallDivider(context),
            mediumCustomSizedBox(context),
            searchQuery.isEmpty
                ? Container()
                : Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: kDefaultScreenPaddingHorizontal(context),
                        vertical: kDefaultScreenPaddingVertical(context)),
                    child: Text(
                      "Search Results",
                      style: mediumLargeTextStyle(context),
                    ),
                  ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: kDefaultScreenPaddingHorizontal(context),
                      vertical: kDefaultScreenPaddingVertical(context)),
                  child: Center(
                    child: customCircularProgress(),
                  ),
                ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (BuildContext context, int i) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  child: ListTile(
                    onTap: () {},
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: const BorderSide(color: Colors.white, width: 0.5),
                    ),
                    leading: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                            ),
                            fit: BoxFit.cover,
                          )),
                      // child: Image.network(
                      //   "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                      //   //transferMoneyList[i]['img']!,
                      //   fit: BoxFit.fill,
                      //   height: imgDimension,
                      //   width: imgDimension,
                      // ),
                    ),
                    // Image.network(
                    //     'https://images.unsplash.com/photo-1614283233556-f35b0c801ef1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c2lkZSUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80',
                    //     height: 30,
                    //     width: 30,
                    // ),
                    title: Text("Aravind S", style: mediumTextStyle(context)),
                    subtitle:
                        Text("1234567890", style: smallTextStyle(context)),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
