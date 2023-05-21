import 'package:client/apis/homeapi.dart';
import 'package:client/apis/setupapi.dart';
import 'package:client/helpers/headers.dart';
import 'package:client/screens/home/addcard.dart';

class AllCardPage extends StatefulWidget {
  static const String routeName = allcard;
  const AllCardPage({super.key});

  @override
  State<AllCardPage> createState() => _AllCardPageState();
}

class _AllCardPageState extends State<AllCardPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool cardActive = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future? _allCardsFuture;
  final HomeScreenAPI _homeScreenAPI = HomeScreenAPI();
  final SetupPinAPI _setupAPI = SetupPinAPI();

  @override
  void initState() {
    super.initState();
    _allCardsFuture = _getCards();
  }

  _getCards() async {
    return await _homeScreenAPI.getAllCards(context: context);
  }

  Future<void> _getRefreshedCardsData() async {
    setState(() {
      _allCardsFuture = _getCards();
    });
  }

  _updateCardStatus({required String cardNumber})async {
    return await _setupAPI.postUpdateCard(context: context, cardNumber: cardNumber);
  }

  @override
  Widget build(BuildContext context) {
    var size = sizeMedia(context);
    return SafeArea(
      child: Scaffold(
        appBar: commonNavbar(context: context, isBack: true),
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: _getRefreshedCardsData,
          color: kPrimaryColor,
          strokeWidth: 3,
          child: FutureBuilder(
            future: _allCardsFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultScreenPaddingHorizontal(context),
                        vertical: kDefaultScreenPaddingVertical(context)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              rowTitleText(
                                  onTap: () {},
                                  context: context,
                                  isCapitalFont: false,
                                  text: "Added Cards",
                                  isViewAll: false),
                              defaultDivider(),
                              mediumCustomSizedBox(context)
                            ],
                          ),
                        ),
                        GestureDetector(
                           onTap: (){
                            if(snapshot.data['total_cards'] < 1){
                              Navigator.push(
                                              context,
                                              CustomRightPageRoute(
                                                  page: const AddCardPage(),
                                                  routeName:
                                                      addcard));
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "You are allowed to add only one card"));
                            }
                           },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(Icons.add_card_outlined,
                            color: kPrimaryColor, size: 24),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            "New",
                            style: mediumTextStyle(context)
                                .copyWith(color: kPrimaryColor),
                          ),
                        ),
                            ],
                          ),
                        )
                      ],
                    )),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data['cards'].length,
                  itemBuilder: (BuildContext context, int i) {
                    return //Primary Card Added
                        Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CreditCardWidget(
                          glassmorphismConfig: useGlassMorphism
                              ? Glassmorphism.defaultConfig()
                              : null,
                          cardNumber: snapshot.data['cards'][i]['card_number'],
                          expiryDate: snapshot.data['cards'][i]['card_expiry'],
                          cardHolderName: snapshot.data['cards'][i]['card_holder_name'],
                          cvvCode: snapshot.data['cards'][i]['card_cvv'],
                          bankName: snapshot.data['cards'][i]['bank_name'],
                          frontCardBorder: null,
                          backCardBorder: null,
                          showBackView: isCvvFocused,
                          obscureCardNumber: true,
                          obscureCardCvv: true,
                          isHolderNameVisible: true,
                          cardBgColor: Colors.white,
                          // backgroundImage: 'assets/images/cardbg.png',
                          backgroundNetworkImage:snapshot.data['cards'][i]['img'],
                          isSwipeGestureEnabled: true,
        
                          onCreditCardWidgetChange:
                              (CreditCardBrand creditCardBrand) {},
                          customCardTypeIcons: <CustomCardTypeIcon>[
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
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ListTile(
                                tileColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  // side: const BorderSide(color: kLavenderGrayColor, width: 0.5),
                                ),
                                title: Text( (snapshot.data['cards'][i]['is_verified']) ? "Card verified" : "Under Verification",
                                    style: mediumTextStyle(context)),
                                subtitle: Text((snapshot.data['cards'][i]['is_active']) ? "Card Enabled" : "Card Disabled",
                                    style: smallTextStyle(context)),
                                trailing: Switch(
                                  value: snapshot.data['cards'][i]['is_active'], //cardActive,
                                  inactiveTrackColor: Colors.grey,
                                  activeColor: Colors.white,
                                  activeTrackColor: kGreenColor,
                                  onChanged: (bool value) => setState(() {

                                    if((snapshot.data['cards'][i]['is_verified'])){
                                        snapshot.data['cards'][i]['is_active'] = value;
                                        overlayLoader(context);
                                        _updateCardStatus(cardNumber:  snapshot.data['cards'][i]['card_number']);
                                    }else{
                                       ScaffoldMessenger.of(context).showSnackBar(
                                    customsnackErrorBar(
                                        context, "Card verification is under progress")); 
                                    }
                                  }),
                                ),
                              ),
                              //Add delete button
                              // smallCustomSizedBox(context),
                              // ElevatedButton(onPressed: (){},
                              //  child: Text("Delete Card", style: mediumTextStyle(context).copyWith(color: Colors.white)),),
                              kSmallDivider(context),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
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
          )
        ),
      ),
    );
  }
}
