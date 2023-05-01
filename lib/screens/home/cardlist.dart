import 'package:client/helpers/headers.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: commonNavbar(context: context, isBack: true),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
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
                    const Icon(Icons.add_card_outlined,color: kPrimaryColor,size: 24),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text("New",style: mediumTextStyle(context).copyWith(color:kPrimaryColor),),
                    ),
                  ],
                )
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (BuildContext context, int i) {
                  return //Primary Card Added
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CreditCardWidget(
                    glassmorphismConfig:
                            useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    bankName: 'Axis Bank',
                    frontCardBorder: null,
                    backCardBorder: null,
                    showBackView: isCvvFocused,
                    obscureCardNumber: true,
                    obscureCardCvv: true,
                    isHolderNameVisible: true,
                    cardBgColor: Colors.white,
                    // backgroundImage: 'assets/images/cardbg.png',
                    backgroundNetworkImage:
                            "https://www.cardexpert.in/wp-content/uploads/2022/02/axis-atlas-banner.png",
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
                                  title: Text("2222 XXXX 4444",
                                      style: mediumTextStyle(context)),
                                  subtitle: Text("Card Enabled ",
                                      style: smallTextStyle(context)),
                                  trailing: Switch(
                                    value: cardActive,
                                    inactiveTrackColor: Colors.grey,
                                    activeColor: Colors.white,
                                    activeTrackColor: kGreenColor,
                                    onChanged: (bool value) => setState(() {
                                      cardActive = value;
                                    }),
                                  ),
                                ),
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
        ),
      ),
    );
  }
}
