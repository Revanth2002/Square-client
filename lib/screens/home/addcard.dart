import 'package:client/apis/setupapi.dart';
import 'package:client/helpers/headers.dart';

class AddCardPage extends StatefulWidget {
  static const String routeName = addcard;
  const AddCardPage({Key? key}) : super(key: key);

  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: kLavenderGrayColor,
        width: 2.0,
      ),
    );
    super.initState();
  }

  final SetupPinAPI _setupPinAPI = SetupPinAPI();

  _postNewCardSetup({required BuildContext context,required String cardNumber,required String expiryMonth,required String cardCvv,required String cardHolder})async{
    return _setupPinAPI.postAddCard(context: context, cardNumber: cardNumber, expiryMonth: expiryMonth, cardCvv: cardCvv, cardHolder: cardHolder);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonNavbar(context: context, isBack: true),
      body: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      rowTitleText(
                          onTap: () {},
                          context: context,
                          isCapitalFont: false,
                          text: "Add a card",
                          isViewAll: false),
                      defaultDivider(),
                      mediumCustomSizedBox(context)
                    ],
                  ),
                ),
                //Primary Card Added
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

                // CreditCardWidget(
                //   glassmorphismConfig: Glassmorphism.defaultConfig(),
                //   cardNumber: cardNumber,
                //   expiryDate: expiryDate,
                //   cardHolderName: cardHolderName,
                //   cvvCode: cvvCode,
                //   bankName: 'Axis Bank',
                //   frontCardBorder:null,
                //   backCardBorder:null,
                //   showBackView: isCvvFocused,
                //   obscureCardNumber: true,
                //   obscureCardCvv: true,
                //   isHolderNameVisible: true,
                //   cardBgColor: kPrimaryColor,
                //   backgroundImage:
                //       useBackgroundImage ? 'assets/images/cardbg.png' : null,
                //   isSwipeGestureEnabled: true,
                //   onCreditCardWidgetChange:
                //       (CreditCardBrand creditCardBrand) {},
                //   customCardTypeIcons: <CustomCardTypeIcon>[
                //     CustomCardTypeIcon(
                //       cardType: CardType.mastercard,
                //       cardImage: Image.asset(
                //         'assets/images/mastercard.png',
                //         height: 48,
                //         width: 48,
                //       ),
                //     ),
                //   ],
                // ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CreditCardForm(
                          formKey: formKey,
                          obscureCvv: false,
                          obscureNumber: false,
                          cardNumber: cardNumber,
                          cvvCode: cvvCode,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          enableCvv: true,
                          cardHolderName: cardHolderName,
                          expiryDate: expiryDate,
                          themeColor: Colors.blue,
                          textColor: kPrimaryColor,
                          cardNumberDecoration: InputDecoration(
                            labelText: 'Card Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
                            hintStyle: const TextStyle(color: kDimGray),
                            labelStyle: const TextStyle(color: kDimGray),
                            focusedBorder: border,
                            enabledBorder: border,
                            fillColor: kLavenderGrayColor,
                            filled: false,
                            prefixIcon: const Icon(Icons.credit_card),
                          ),
                          expiryDateDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: kDimGray),
                            labelStyle: const TextStyle(color: kDimGray),
                            focusedBorder: border,
                            enabledBorder: border,
                            fillColor: kLavenderGrayColor,
                            filled: false,
                            labelText: 'Expired Date',
                            hintText: 'XX/XX',
                            prefixIcon: const Icon(Icons.date_range),
                          ),
                          cvvCodeDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: kDimGray),
                            labelStyle: const TextStyle(color: kDimGray),
                            focusedBorder: border,
                            enabledBorder: border,
                            fillColor: kLavenderGrayColor,
                            filled: false,
                            labelText: 'CVV',
                            hintText: 'XXX',
                            prefixIcon: const Icon(Icons.lock_outline),
                          ),
                          cardHolderDecoration: InputDecoration(
                            hintStyle: const TextStyle(color: kDimGray),
                            labelStyle: const TextStyle(color: kDimGray),
                            focusedBorder: border,
                            enabledBorder: border,
                            fillColor: kLavenderGrayColor,
                            filled: false,
                            labelText: 'Card Holder',
                            prefixIcon: const Icon(Icons.person_outline),
                          ),
                          onCreditCardModelChange: onCreditCardModelChange,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    kDefaultScreenPaddingHorizontal(context)),
                            child: primaryBtn(
                                context: context,
                                onTap: _onValidate,
                                btnText: "Add Card",
                                isOutline: false)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onValidate() {
    if (formKey.currentState!.validate()) {
      if(cardHolderName.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter card holder name'),
            backgroundColor: Colors.red,
          ),
        );
      }else{
        //remove spaces in cardnumber
        cardNumber = cardNumber.replaceAll(' ', '');
        overlayLoader(context);
        _postNewCardSetup(context: context, cardNumber: cardNumber, expiryMonth: expiryDate, cardCvv: cvvCode, cardHolder: cardHolderName);
      }
      //Print all the data
      print('Card Number: ' + cardNumber);
      print('Expiry Date: ' + expiryDate);
      print('Card Holder Name: ' + cardHolderName);
      print('CVV: ' + cvvCode);
    } else {
      print('invalid!');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter card details'),
            backgroundColor: Colors.red,
          ),
        );
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
}
