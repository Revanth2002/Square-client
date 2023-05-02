import 'package:client/helpers/headers.dart';

class PersonalInfoPage extends StatefulWidget {
  static const routeName = personalinfopage;
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonNavbar(context: context, isBack: false),
      backgroundColor: Colors.white,
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
                "A Last Step to First Pay",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: isMobile(context) ? 27.0 : 32.0,
                    fontWeight: FontWeight.w900,
                    color: kTitleColor,
                    fontFamily: kQuickSandBold),
              ),
              smallCustomSizedBox(context),
              defaultDivider(),
              mediumCustomSizedBox(context),
              mediumCustomSizedBox(context),
              Container(
                margin: EdgeInsets.only(
                    top: kDefaultScreenPaddingVertical(context)),
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
                      child: TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.text,

                        enableSuggestions: true,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                          enabled: true,
                          labelText: 'Enter your Name',
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
mediumCustomSizedBox(context),
                    mediumCustomSizedBox(context),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: kLightLavengerGrayColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r"\s")),
                        ],
                        enableSuggestions: true,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                          enabled: true,
                          labelText: 'Enter your Email',
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
                    mediumCustomSizedBox(context),
                    primaryBtn(
                      isOutline: true,
                      btnColor: kPrimaryColor,
                      context: context,
                      onTap: () {
                        // if (_otpController.text.length == 6) {
                        //   overlayLoader(context);
                        //   _otpVerificationMethod(otp: _otpController.text);
                        // } else {
                        //   ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Please enter a proper 6 digit otp"));
                        // }
                      },
                      btnText: "Start Pay",
                      vertical: 20,
                    ),
                    //          Container(
                    //   margin: EdgeInsets.symmetric(
                    //       horizontal: kDefaultScreenPaddingHorizontal(context),
                    //       vertical: kDefaultScreenPaddingVertical(context)),
                    //     child: RichText(
                    //         text: TextSpan(
                    //           style:  smallTextStyle(context).copyWith(
                    //                 height: 1.2, color: kGraycolor, fontFamily: kMuktaRegular,),
                    //           text: 'By booking appointment, you agree to our ',
                    //           children: <TextSpan>[
                    //             TextSpan(text: 'Terms & Conditions',style: smallTextStyle(context).copyWith(
                    //               color:Colors.blue,fontFamily:kMuktaBold,
                    //               decoration : TextDecoration.underline
                    //               )),
                    //           ],
                    //         ),
                    //       ),
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
