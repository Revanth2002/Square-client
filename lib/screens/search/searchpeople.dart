import 'package:client/apis/searchapi.dart';
import 'package:client/helpers/headers.dart';
import 'package:client/screens/home/peopletransaction.dart';

class SearchPeoplePage extends StatefulWidget {
  static const String routeName = searchpeoplepage;
  final bool isOneTimePop;
  final bool isMobileNumber;
  const SearchPeoplePage({Key? key, required this.isOneTimePop, required this.isMobileNumber})
      : super(key: key);

  @override
  _SearchPeoplePageState createState() => _SearchPeoplePageState();
}

class _SearchPeoplePageState extends State<SearchPeoplePage> {
  final TextEditingController _searchController = TextEditingController();
  Future? _searchResultsFuture;

  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _searchController.text = "";
  }

  final SearchAPI _searchAPI = SearchAPI();

  Future<void> _performSearchResults({required String query})async {
    setState(() {
      _searchResultsFuture = _searchAPI.getSearchResults(context: context, query: query);
    });
    // return _searchAPI.getSearchResults(context: context, query: query);
  }


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
                    widget.isMobileNumber ? "Send Money using Mobile" : "Send Money to your friends",
                    style: ultraLargeTextStyle(context)
                        .copyWith(fontFamily: kMuktaRegular),
                  ),
                  smallCustomSizedBox(context),
                  Text(
                    widget.isMobileNumber ? "Start typing a number" :  "Start searching now",
                    style:
                        mediumLargeTextStyle(context).copyWith(color: kDimGray
                            //fontFamily : kQuickSandBold
                            ),
                  ),
                  mediumCustomSizedBox(context),
                  smallCustomSizedBox(context),
                  DynamicSearch(
                    placeholder: widget.isMobileNumber ? "Search using number" : "Search for a user",
                      controller: _searchController,
                      performSearch: (value) {
                        // setState(() {
                        //   searchQuery = value;
                        // });
                        overlayLoader(context);
                        _performSearchResults(query: value);
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
                // Container(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: kDefaultScreenPaddingHorizontal(context),
                //       vertical: kDefaultScreenPaddingVertical(context)),
                //   child: Center(
                //     child: customCircularProgress(),
                //   ),
                // ),

                
            FutureBuilder(
              future: _searchResultsFuture,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return snapshot.data['users'].length > 0 ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data['users'].length,
              itemBuilder: (BuildContext context, int i) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  child: ListTile(
                     onTap: () => Navigator.push(
                                                      context,
                                                      CustomRightPageRoute(
                                                          page:
                                                              PeopleTransactionPage(toPid: snapshot.data['users'][i]['pid']),
                                                          routeName:
                                                              peopletransactionpage)),
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: const BorderSide(color: Colors.white, width: 0.5),
                    ),
                    leading: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              snapshot.data['users'][i]['img'],
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
                    title: Text(snapshot.data['users'][i]['name'], style: mediumTextStyle(context)),
                    subtitle:
                        Text(snapshot.data['users'][i]['mobile'], style: smallTextStyle(context)),
                  ),
                );
              },
            ) : Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: kDefaultScreenPaddingHorizontal(context),
                        vertical: kDefaultScreenPaddingVertical(context)),
                    child: Text(
                      "No Search Results Found",
                      style: mediumLargeTextStyle(context),
                    ),
                  );
                }else if (snapshot.hasError) {
                    return defaultErrordialog(
                        context: context,
                        errorCode: ES_0060,
                        message: "Something went wrong.Try again Later");
                  }
                  return Container();
              },
            )
            
          
          
          
          ],
        ),
      ),
    );
  }
}
