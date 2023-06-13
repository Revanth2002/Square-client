import 'package:client/apis/homeapi.dart';
import 'package:client/helpers/headers.dart';
import 'package:client/screens/components/searchbox.dart';
import 'package:client/screens/home/addcard.dart';
import 'package:client/screens/home/cardlist.dart';
import 'package:client/screens/home/notifications.dart';
import 'package:client/screens/home/peopletransaction.dart';
import 'package:client/screens/home/profile.dart';
import 'package:client/screens/home/scanqr.dart';
import 'package:client/screens/home/setuppin.dart';
import 'package:client/screens/home/transactions.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class HomePage extends StatefulWidget {
  static const routeName = homepage;
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String cardNumber = '2444 1234 5555';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isCardAdded = true;

  final transferMoneyList = [
    {"id": "1", "name": "To Mobile Number", "img": "assets/images/mobile.png"},
    {"id": "2", "name": "To People", "img": "assets/images/contactless.png"},
    {"id": "3", "name": "Scan to Pay", "img": "assets/images/qr.png"},
    {"id": "4", "name": "Transactions", "img": "assets/images/send.png"}
  ];

  Future? _homeScreenFuture;
  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
    _homeScreenFuture = _getHomeScreenData();
  }

  _getHomeScreenData() async {
    return await HomeScreenAPI().getHomeScreen(context: context);
  }

  Future<void> _getRefreshedHomeScreenData() async {
    setState(() {
      _homeScreenFuture = _getHomeScreenData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = sizeMedia(context);

    var imgDimensions = smallMobile(context)
        ? size.width / 8
        : largeMobile(context)
            ? size.width / 9
            : isBetweenMT2(context)
                ? size.width / 11
                : isBetweenMT1(context)
                    ? size.width / 13
                    : isBetweenTD2(context)
                        ? size.width / 15
                        : size.width / 16;

    var imgDimension = 30.0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: RefreshIndicator(
              onRefresh: _getRefreshedHomeScreenData,
              color: kPrimaryColor,
              strokeWidth: 3,
              child: FutureBuilder(
                future: _homeScreenFuture,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: isMobile(context) ? 70 : 90,
                                  width: size.width,
                                  padding: EdgeInsets.only(
                                    left: kScreenMarginHorizontal(context),
                                    right: kScreenMarginHorizontal(context),
                                    top: 15,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () => Navigator.push(
                                                  context,
                                                  CustomRightPageRoute(
                                                      page:
                                                          const MyProfilePage(),
                                                      routeName: profilepage)),
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                  image: DecorationImage(
                                                      image: NetworkImage(snapshot
                                                              .data['img'] ??
                                                          "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () => Navigator.push(
                                                            context,
                                                            CustomRightPageRoute(
                                                                page: const ScanQrPage(),
                                                                routeName: scanqrpage)),
                                                      child: Container(
                                                        height: 45,
                                                        width: 45,
                                                        decoration:
                                                            BoxDecoration(
                                                          // color: kLavenderGrayColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      6.0),
                                                        ),
                                                        child: const Icon(
                                                            Icons
                                                                .qr_code_scanner_outlined,
                                                            color:
                                                                kPrimaryColor),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () => Navigator.push(
                                                          context,
                                                          CustomRightPageRoute(
                                                              page:
                                                                  const NotificationPage(),
                                                              routeName:
                                                                  notificationpage)),
                                                      child: Container(
                                                        height: 45,
                                                        width: 45,
                                                        decoration:
                                                            BoxDecoration(
                                                          // color: kLavenderGrayColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      6.0),
                                                        ),
                                                        child: const Icon(
                                                            Icons.notifications,
                                                            color:
                                                                kPrimaryColor),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          ])
                                    ],
                                  ),
                                )
                              ]),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: ListTile(
                                            tileColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              // side: const BorderSide(color: kLavenderGrayColor, width: 0.5),
                                            ),
                                            title: Text(
                                                "${snapshot.data['mobile']}@zeropay",
                                                style:
                                                    mediumTextStyle(context)),
                                            subtitle: Text("Primary ZeroPay ID",
                                                style: smallTextStyle(context)),
                                            trailing: const Icon(
                                                Icons.verified_rounded,
                                                color: kGreenColor,
                                                size: 20),
                                          ),
                                        ),

                                        //No Primary Card
                                        if (snapshot.data['is_card_added'] ==
                                            false)
                                          GestureDetector(
                                            onTap: () => Navigator.push(
                                                context,
                                                CustomRightPageRoute(
                                                    page: const AddCardPage(),
                                                    routeName: addcard)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: DottedBorder(
                                                color: kPrimaryColor,
                                                strokeWidth: 1,
                                                dashPattern: [
                                                  5,
                                                  5,
                                                ],
                                                child: Container(
                                                  height: 160,
                                                  width: size.width,
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Center(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .add_circle_rounded,
                                                          color: kPrimaryColor,
                                                          size: 40,
                                                        ),
                                                        smallCustomSizedBox(
                                                            context),
                                                        Text(
                                                          "Add a card",
                                                          style: mediumLargeTextStyle(
                                                                  context)
                                                              .copyWith(
                                                                  color:
                                                                      kPrimaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        smallCustomSizedBox(context),

                                        //Primary Card Added
                                        if (snapshot.data['is_card_added'] ==
                                            true)
                                          CreditCardWidget(
                                            glassmorphismConfig:
                                                useGlassMorphism
                                                    ? Glassmorphism
                                                        .defaultConfig()
                                                    : null,
                                            cardNumber:
                                                snapshot.data['primary_card']
                                                    ['card_number'],
                                            expiryDate: snapshot
                                                    .data['primary_card'][
                                                'card_expiry'], //"10/23", // expiryDate,
                                            cardHolderName: snapshot
                                                    .data['primary_card'][
                                                'card_holder_name'], // cardHolderName,
                                            cvvCode:
                                                snapshot.data['primary_card']
                                                    ['card_cvv'],
                                            bankName:
                                                snapshot.data['primary_card']
                                                    ['bank_name'],
                                            frontCardBorder:
                                                null, //Border.all(color: Colors.grey) ,
                                            backCardBorder:
                                                null, //Border.all(color: Colors.grey) ,
                                            showBackView: isCvvFocused,
                                            obscureCardNumber: true,
                                            obscureCardCvv: true,
                                            isHolderNameVisible: true,
                                            cardBgColor: Colors.white,
                                            // backgroundImage: 'assets/images/cardbg.png',
                                            backgroundNetworkImage: snapshot
                                                        .data['primary_card']
                                                    ['card_img'] ??
                                                "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                            isSwipeGestureEnabled: true,
                                            onCreditCardWidgetChange:
                                                (CreditCardBrand
                                                    creditCardBrand) {},
                                            customCardTypeIcons: <
                                                CustomCardTypeIcon>[
                                              CustomCardTypeIcon(
                                                cardType: CardType.mastercard,
                                                cardImage: Image.asset(
                                                  'assets/images/mastercard.png',
                                                  height: 48,
                                                  width: 48,
                                                ),
                                              ),
                                              CustomCardTypeIcon(
                                                cardType: CardType.visa,
                                                cardImage: Image.asset(
                                                  'assets/images/visa.png',
                                                  height: 48,
                                                  width: 48,
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                  mediumCustomSizedBox(context),

                                  //bank accounts linked
                                  if (snapshot.data['is_pin_set'] == false)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: ListTile(
                                        onTap: () => Navigator.push(
                                            context,
                                            CustomRightPageRoute(
                                                page: SetupPinPage(
                                                    isPinSetup: false),
                                                routeName: setuppin)),
                                        tileColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side: const BorderSide(
                                              color: kLavenderGrayColor,
                                              width: 0.5),
                                        ),
                                        // leading: Image.asset(
                                        //   'assets/images/bank.png',
                                        //   height: 30,
                                        //   width: 30,
                                        // ),
                                        leading: const Icon(
                                            Icons.pending_outlined,
                                            color: kPinkRedishColor,
                                            size: 30),
                                        title: Text(
                                            "Tap to setup your zeropay pin",
                                            style: mediumTextStyle(context)),
                                        subtitle: Text(
                                            "Transaction PIN setup is required",
                                            style: smallTextStyle(context)),
                                        trailing: const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: kPinkRedishColor,
                                            size: 20),
                                      ),
                                    ),

                                  mediumCustomSizedBox(context),
                                  //Linked Acccounts
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // Text("Primary Account".toUpperCase(),
                                        // style: mediumTextStyle(context),),
                                        Container(
                                            child: rowTitleText(
                                                onTap: () {},
                                                context: context,
                                                isCapitalFont: false,
                                                text: "Linked Accounts",
                                                isViewAll: false)),

                                        mediumCustomSizedBox(context),
                                        //bank accounts linked
                                        ListTile(
                                          onTap: () => Navigator.push(
                                              context,
                                              CustomRightPageRoute(
                                                  page: const AllCardPage(),
                                                  routeName: allcard)),
                                          tileColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            side: const BorderSide(
                                                color: kLavenderGrayColor,
                                                width: 0.5),
                                          ),
                                          leading: Image.asset(
                                            'assets/images/bank.png',
                                            height: 30,
                                            width: 30,
                                          ),
                                          title: Text("Linked Bank Account",
                                              style: mediumTextStyle(context)),
                                          subtitle: Text(
                                              "${snapshot.data['cards_count']} cards linked",
                                              style: smallTextStyle(context)),
                                          trailing: const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: kPrimaryColor,
                                              size: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                  mediumCustomSizedBox(context),
                                  smallCustomSizedBox(context),
                                  //Transfer Money
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // Text("Primary Account".toUpperCase(),
                                        // style: mediumTextStyle(context),),
                                        Container(
                                            child: rowTitleText(
                                                onTap: () {},
                                                context: context,
                                                isCapitalFont: false,
                                                text: "Transfer Money",
                                                isViewAll: false)),

                                        // mediumCustomSizedBox(context),
                                        // Icons features

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            // mediumTitleText(
                                            //     context: context,
                                            //     text: "Transfer Money",
                                            //     color: Colors.black),
                                            // mediumCustomSizedBox(context),

                                            //All Specialisations
                                            GridView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        childAspectRatio:
                                                            smallMobile(context)
                                                                ? 0.8
                                                                : largeMobile(
                                                                        context)
                                                                    ? 0.9
                                                                    : 3.3 / 3,
                                                        crossAxisCount: smallMobile(
                                                                context)
                                                            ? 4
                                                            : largeMobile(
                                                                    context)
                                                                ? 4
                                                                : isBetweenMT2(
                                                                        context)
                                                                    ? 4
                                                                    : isBetweenMT1(
                                                                            context)
                                                                        ? 5
                                                                        : 6,
                                                        crossAxisSpacing: 10,
                                                        mainAxisSpacing: 10),
                                                itemCount:
                                                    transferMoneyList.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int i) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      if(transferMoneyList[i]['id'] == "1"){
                                                        Navigator.push(
                                                            context,
                                                            CustomRightPageRoute(
                                                                page: const SearchPeoplePage(isOneTimePop: false,isMobileNumber: true),
                                                                routeName: searchpeoplepage));
                                                      }else if(transferMoneyList[i]['id'] == "2"){
                                                        Navigator.push(
                                                            context,
                                                            CustomRightPageRoute(
                                                                page: const SearchPeoplePage(isOneTimePop: false,isMobileNumber: false),
                                                                routeName: searchpeoplepage));
                                                      }else if(transferMoneyList[i]['id'] == "3"){
                                                        Navigator.push(
                                                            context,
                                                            CustomRightPageRoute(
                                                                page: const ScanQrPage(),
                                                                routeName: scanqrpage));
                                                      }else if(transferMoneyList[i]['id'] == "4"){
                                                        Navigator.push(
                                                            context,
                                                            CustomRightPageRoute(
                                                                page: const AllTransactions(),
                                                                routeName: alltransactions));
                                                      }
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          transferMoneyList[i]
                                                              ['img']!,
                                                          fit: BoxFit.fill,
                                                          height: imgDimension,
                                                          width: imgDimension,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: isMobile(
                                                                          context)
                                                                      ? 4
                                                                      : 7),
                                                          child: Text(
                                                              transferMoneyList[
                                                                  i]['name']!,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style:
                                                                  smallTextStyle(
                                                                      context)),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  mediumCustomSizedBox(context),
                                  //Recent Transactions
                                  if (snapshot.data['people_count'] != 0)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // Text("Primary Account".toUpperCase(),
                                          // style: mediumTextStyle(context),),
                                          Container(
                                              child: rowTitleText(
                                                  onTap: () => Navigator.push(
                                                      context,
                                                      CustomRightPageRoute(
                                                          page:
                                                              const SearchPeoplePage(
                                                            isOneTimePop: false,
                                                            isMobileNumber: false,
                                                          ),
                                                          routeName:
                                                              alltransactions)),
                                                  context: context,
                                                  isCapitalFont: false,
                                                  text: "Recent People",
                                                  isViewAll: true)),

                                          // mediumCustomSizedBox(context),
                                          GridView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      childAspectRatio:
                                                          smallMobile(context)
                                                              ? 0.8
                                                              : largeMobile(
                                                                      context)
                                                                  ? 0.9
                                                                  : 3.3 / 3,
                                                      crossAxisCount: smallMobile(
                                                              context)
                                                          ? 4
                                                          : largeMobile(context)
                                                              ? 4
                                                              : isBetweenMT2(
                                                                      context)
                                                                  ? 4
                                                                  : isBetweenMT1(
                                                                          context)
                                                                      ? 5
                                                                      : 6,
                                                      crossAxisSpacing: 10,
                                                      mainAxisSpacing: 10),
                                              itemCount: snapshot
                                                  .data['people'].length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int i) {
                                                return GestureDetector(
                                                  onTap: () => Navigator.push(
                                                      context,
                                                      CustomRightPageRoute(
                                                          page:
                                                              PeopleTransactionPage(toPid: snapshot.data['people'][i]['pid']),
                                                          routeName:
                                                              peopletransactionpage)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        height: imgDimension,
                                                        width: imgDimension,
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(snapshot.data['people']
                                                                              [
                                                                              i]
                                                                          [
                                                                          'img'] ??
                                                                      "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )),
                                                        // child: Image.network(
                                                        //   "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                                        //   //transferMoneyList[i]['img']!,
                                                        //   fit: BoxFit.fill,
                                                        //   height: imgDimension,
                                                        //   width: imgDimension,
                                                        // ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: isMobile(
                                                                        context)
                                                                    ? 4
                                                                    : 7),
                                                        child: Text(
                                                            snapshot.data[
                                                                    'people'][i]
                                                                ['name'],
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style:
                                                                smallTextStyle(
                                                                    context)),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),

                                          /*
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 6,
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
                                }), */
                                        ],
                                      ),
                                    ),

                                  /*----------start second promoitons box --------------*/
                                  ///Second Promotions Box
                                  mediumCustomSizedBox(context),
                                  Container(
                                    width: size.width,
                                    height: isMobile(context)
                                        ? size.height / 4.3
                                        : size.height / 3.9,
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            kDefaultScreenPaddingHorizontal(
                                                context),
                                        vertical: kDefaultScreenPaddingVertical(
                                            context)),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "${snapshot.data['last_promotional_img']}"))),
                                  ),
                                  mediumCustomSizedBox(context),
                                  /*----------end second promoitons box --------------*/

                                  /*----------start end details box --------------*/
                                  ///End Details Box
                                  Container(
                                    width: size.width,
                                    decoration: const BoxDecoration(
                                      color: kSecondaryColor,
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal:
                                              kDefaultScreenPaddingHorizontal(
                                                  context),
                                          vertical:
                                              kDefaultScreenPaddingVertical(
                                                  context)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          mediumCustomSizedBox(context),
                                          // mediumCustomSizedBox(context),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              //Title Text of ZeroPay
                                              Text(
                                                "With ZeroPay ,",
                                                style: mediumLargeTextStyle(
                                                        context)
                                                    .copyWith(
                                                        color:
                                                            Color(0xff242c78),
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),

                                              // verticialIconText(
                                              //     text: "2", icon: FontAwesomeIcons.hospitalAlt),
                                              // verticialIconText(
                                              //     text: "12", icon: FontAwesomeIcons.userMd),
                                              // verticialIconText(text: "50", icon: Icons.person),
                                            ],
                                          ),
                                          // mediumCustomSizedBox(context),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    kDefaultScreenPaddingHorizontal(
                                                        context),
                                                vertical:
                                                    kDefaultScreenPaddingVertical(
                                                        context)),
                                            child: Text(
                                              "Experience the ease and speed of our mobile app's faster payments feature. Send and receive payments securely, anytime, anywhere, with just a few taps on your phone.",
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                              style: mediumTextStyle(context)
                                                  .copyWith(
                                                      color: Color(0xff242c78),
                                                      wordSpacing: 0.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  /*----------end end details box --------------*/
                                ],
                              )),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
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
              ))),
    );
  }

  void _onValidate() {
    if (formKey.currentState!.validate()) {
      print('valid!');
    } else {
      print('invalid!');
    }
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  Widget verticialIconText({required String text, required IconData icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: kPrimaryColor,
        ),
        smallCustomSizedBox(context),
        Text(
          text,
          style: mediumTextStyle(context)
              .copyWith(color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
