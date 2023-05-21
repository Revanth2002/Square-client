import 'dart:async';

import 'package:client/apis/paymentapi.dart';
import 'package:client/helpers/headers.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PayPinPage extends StatefulWidget {
  static const String routeName = paypinpage;
  
  final String recPid;
  final String recAmt;
  const PayPinPage({Key? key, required this.recPid, required this.recAmt}) : super(key: key);

  @override
  _PayPinPageState createState() => _PayPinPageState();
}

class _PayPinPageState extends State<PayPinPage> {
  final TextEditingController _pinController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

final PaymentAPI _paymentAPI = PaymentAPI();

  _performPayMoney({required String pin})async {
    return _paymentAPI.postSendMoney(context: context, pin: pin, toPid: widget.recPid, amount: widget.recAmt);
  }

  @override
  Widget build(BuildContext context) {
    var size = sizeMedia(context);
    return Scaffold(
      appBar: commonNavbar(context: context, isBack: true),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                mediumCustomSizedBox(context),
                //Add security icon
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Icon(
                      //   Icons.lock_outline,
                      //   size: 40,
                      //   color: kPrimaryColor,
                      // ),
                      Text("Enter PIN", style: largeTextStyle(context)),
                    ],
                  ),
                ),
                mediumCustomSizedBox(context),
                Center(
                  child: Container(
                      height: 50,
                      width: 200,
                      child: Text(
                          "Enter your zerpay transaction PIN to continue",
                          textAlign: TextAlign.center,
                          style: smallTextStyle(context))),
                ),
                mediumCustomSizedBox(context),
                /*
                  Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: kLightLavengerGrayColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child:TextFormField(
                    controller: _otpController,
                   keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(6)
                              ],
                    enableSuggestions: true,
                    enableInteractiveSelection: true,
                    decoration: InputDecoration(
                      enabled: true,
                      labelText: '',
                      labelStyle: const TextStyle(
                        color: kGraycolor,
                        fontSize: 13.0,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: kGraycolor),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(color: kGraycolor),
                      ),
                    ),
                    // maxLength: 10,
                    ),  
                          ),
                  */
                Container(
                  width: 350,
                  margin: EdgeInsets.symmetric(
                      vertical: kDefaultScreenPaddingVertical(context),
                      horizontal: size.width * 0.15),
                  child: Form(
                    key: formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          appContext: context,
                          autoDismissKeyboard: true,
                          // pastedTextStyle: TextStyle(
                          //   color: Colors.green.shade600,
                          //   fontWeight: FontWeight.bold,
                          // ),
                          length: 4,
                          obscureText: true,
                          obscuringCharacter: '*',
                          autoFocus: true,
                          obscuringWidget: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: kPrimaryColor.withOpacity(0.5),
                            ),
                          ),
                          blinkWhenObscuring: false,
                          animationType: AnimationType.none,
                          // validator: (v) {
                          //   if (v!.length < 3) {
                          //     return "I'm from validator";
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          pinTheme: PinTheme(
                              shape: PinCodeFieldShape.circle,
                              borderRadius: BorderRadius.circular(25),
                              fieldHeight: 15,
                              fieldWidth: 15,
                              activeFillColor: Colors.white,
                              borderWidth: 2,
                              inactiveColor: Colors.grey.shade300,
                              inactiveFillColor: Colors.white,
                              selectedColor: Colors.black,
                              selectedFillColor: kLavenderGrayColor,
                              activeColor: kPrimaryColor),
                          cursorColor: Colors.black,
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: _pinController,
                          keyboardType: TextInputType.number,
                          boxShadows: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          onCompleted: (v) {
                            debugPrint("Completed");
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            debugPrint(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            debugPrint("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        )),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: kDefaultScreenPaddingVertical(context),
                    horizontal: size.width * 0.15),
                child: primaryBtn(
                    context: context,
                    onTap: () {
                      if(currentText.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Please enter your pin"));
                      }else{
                        overlayLoader(context);
                        _performPayMoney(pin: currentText);
                      }
                    },
                    btnText: "Pay",
                    isOutline: false),
              ),
            )
          ],
        ),
      ),
    );
  }
}
