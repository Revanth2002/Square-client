import 'dart:async';

import 'package:client/helpers/headers.dart';

class OtpPage extends StatefulWidget {
  static const routeName = otppage;
  String secretCode;
  final String phoneNumber;
  OtpPage({ Key? key ,required this.secretCode,required this.phoneNumber}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  int start = 10;
  bool wait = true;
  late Timer _timer;

  final TextEditingController _otpController = TextEditingController();
  //final AuthenticationAPI _authapi = AuthenticationAPI();

  @override
  @override
    void initState() {
      super.initState();
      startTimer();
    }    

/*
  _otpVerificationMethod({required String otp})async{
    return await _authapi.postOtpVerification(context: context, otp: otp, code: widget.secretCode).then((res){
      if(res==false){
       Loader.hide(); 
      }
    });
  }

  _postResendOtp() async {
    return await _authapi.postResendOtp(
        context: context, phonenumber: widget.phoneNumber).then((res) {
          print(res);
          if(res['status'] ==true){
            setState(() {
                      start = 10;
                      wait = true;
                      widget.secretCode = res['code'];
                      //buttonName = "Resend";
                    });
                    startTimer();
          }
        });
  }

  */

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: commonNavbar(context: context, isBack: true),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            margin: screenPads(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                mediumCustomSizedBox(context), 
                Text(
                  "Enter your OTP.",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: isMobile(context) ? 27.0 : 32.0,
                      fontWeight: FontWeight.w900,
                      color: kTitleColor,
                      fontFamily: kQuickSandBold),
                ), 
                SizedBox(
                  height: isMobile(context) ? 35.0 : 40.0,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                  labelText: 'Enter OTP',
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
                        
                        //  TextFormField(
                        //   controller: _otpController,
                        //   style: largeTextStyle(context),
                        //   keyboardType: TextInputType.number,
                        //   inputFormatters: [
                        //     FilteringTextInputFormatter.digitsOnly,
                        //     LengthLimitingTextInputFormatter(6)
                        //   ],
                        //   cursorColor: kPrimaryColor,
                        //   decoration: InputDecoration(
                        //     hintText: "6 Digit OTP",
                        //     hintStyle: mediumTextStyle(context)
                        //         .copyWith(color: kDarkGray),
                        //     border: InputBorder.none,
                        //     contentPadding: const EdgeInsets.symmetric(
                        //         vertical: 6, horizontal: 8),
                        //   ),
                        // ),
                      ),
                      Container(
                        height: 45,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Resend OTP ?",
                              style: mediumTextStyle(context).copyWith(color:kDimGray,letterSpacing : 0.3),
                            ),
                            RotatedBox(quarterTurns: 1,child : smallCustomSizedBox(context)),
                //             onTap: wait
                // ? null
                // : () async {
                //     setState(() {
                //       start = 30;
                //       wait = true;
                //       buttonName = "Resend";
                //     });
                //   },
                  if(wait == true) Text(
                              "$start",
                              style: mediumTextStyle(context).copyWith(color:kPrimaryColor,letterSpacing : 0.3,fontFamily:kMuktaBold),
                            ),  
            if(wait == false) GestureDetector(
              onTap : () async {
                //overlayLoader(context);
                //_postResendOtp();
                    
                  },
              child: Text(
                                "Resend",
                                style: mediumTextStyle(context).copyWith(color:kPrimaryColor,letterSpacing : 0.3,fontFamily:kMuktaBold),
                              ),
            ),  
                                    ],
                        ),
                      ),
                      mediumCustomSizedBox(context),
                   primaryBtn(
                         isOutline: false,btnColor: kPrimaryColor,
                          context: context, onTap: () {
                            if (_otpController.text.length == 6) {
                              //overlayLoader(context);
                              //_otpVerificationMethod(otp: _otpController.text);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Please enter a proper 6 digit otp"));
                            }
                          },
                          btnText: "Start Pay",vertical:20,),
                       Container(
                margin: EdgeInsets.symmetric(
                    horizontal: kDefaultScreenPaddingHorizontal(context),
                    vertical: kDefaultScreenPaddingVertical(context)),
                  child: RichText(
                      text: TextSpan(
                        style:  smallTextStyle(context).copyWith(
                              height: 1.2, color: kGraycolor, fontFamily: kMuktaRegular,),                   
                        text: 'By logging in, you agree to our ',
                        children: <TextSpan>[
                          TextSpan(text: 'Terms & Conditions',style: smallTextStyle(context).copyWith(
                            color:Colors.blue,fontFamily:kMuktaBold,
                            decoration : TextDecoration.underline
                            )),
                        ],
                      ),
                    ),
              )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

    void startTimer() {
    const onsec = Duration(seconds: 1);
   
     _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer.cancel();
    super.dispose();
  }

}