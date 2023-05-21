import 'package:client/apis/authapi.dart';
import 'package:client/helpers/headers.dart';
import 'package:client/screens/auth/otppage.dart';
import 'package:client/screens/auth/registerpage.dart';


class LoginPage extends StatefulWidget {
  static const routeName = loginpage;
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneNumberController = TextEditingController();

  final AuthenticationAPI _authapi = AuthenticationAPI();

  _postLoginUser({required String phonenumber}) async {
    return await _authapi.postLoginUser(
        context: context, phonenumber: phonenumber);
  }

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
                  "Enter your mobile number",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                          fontSize: isMobile(context) ? 27.0 : 32.0,
                          fontWeight: FontWeight.w900,
                          color: kTitleColor,
                          fontFamily: kQuickSandBold),
                ),
              mediumCustomSizedBox(context),
                defaultDivider(),
                mediumCustomSizedBox(context),
                
                SizedBox(
                  height: isMobile(context) ? 35.0 : 40.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: kLightLavengerGrayColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextFormField(
                        controller: _phoneNumberController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        keyboardType: TextInputType.number,
                        enableSuggestions: true,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                          enabled: true,
                          labelText: 'Mobile Number',
                          labelStyle: const TextStyle(
                            color: kGraycolor,
                            fontSize: 13.0,
                          ),
                          prefix: Text(
                            "+91 ",
                            style: TextStyle(
                                color: kGraycolor,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500),
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
                      ),
                    ),
                    primaryBtn(
                      isOutline: false,
                      btnColor: kPrimaryColor,
                      context: context,
                      onTap: () {
                        if(_phoneNumberController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                          customsnackErrorBar(
                              context, "Please enter your phone number")); 
                        } else {
                          overlayLoader(context);
                          _postLoginUser(phonenumber: _phoneNumberController.text.trim());
                        //  Navigator.push(
                        //   context,
                        //   CustomRightPageRoute(
                        //       page: OtpPage(phoneNumber: "",pid: ""),
                        //       routeName: otppage));
                        }
                      },
                      btnText: "Get OTP",
                      vertical: 20,
                    ),
                    mediumCustomSizedBox(context),
                   GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          CustomRightPageRoute(
                              page: RegisterPage(),
                              routeName: registerpage)),
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    kDefaultScreenPaddingHorizontal(context),
                                vertical: kDefaultScreenPaddingVertical(context)),
                            child: RichText(
                              text: TextSpan(
                                style: smallTextStyle(context).copyWith(
                                  height: 1.2,
                                  color: kGraycolor,
                                  fontFamily: kMuktaRegular,
                                ),
                                text: 'New to zeropay ?',
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' Register ',
                                      style: smallTextStyle(context).copyWith(
                                          color: Colors.blue,
                                          fontFamily: kMuktaBold,
                                          decoration: TextDecoration.underline)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
