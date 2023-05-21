import 'package:client/apis/authapi.dart';
import 'package:client/helpers/headers.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = registerpage;
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final AuthenticationAPI _authapi = AuthenticationAPI();

  _postRegisterUser(
      {required String phonenumber,
      required String username,
      required String email}) async {
    return await _authapi.postRegisterUser(
        context: context,
        phonenumber: phonenumber,
        userName: username,
        email: email);
  }

bool validateEmail(String email) {
  // Regular expression to match email addresses
  final regex = RegExp(r"^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
  return regex.hasMatch(email);
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
                  "Let's Begin",
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
                            labelText: 'Mobile',
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
                            labelText: 'Email',
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
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: kLightLavengerGrayColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          controller: _usernameController,
                          keyboardType: TextInputType.text,

                          enableSuggestions: true,
                          enableInteractiveSelection: true,
                          decoration: InputDecoration(
                            enabled: true,
                            labelText: 'Name',
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
                        isOutline: false,
                        btnColor: kPrimaryColor,
                        context: context,
                        onTap: () {
                          //check if name is empty, email is matched format,mobile is empty
                          if(_usernameController.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(
                                customsnackErrorBar(context,"Name is empty"));
                          }else if(_emailController.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(
                                customsnackErrorBar(context,"Email is empty"));
                          }else if(_phoneNumberController.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(
                                customsnackErrorBar(context,"Mobile is empty"));
                          }else if(validateEmail(_emailController.text) == false){
                            ScaffoldMessenger.of(context).showSnackBar(
                                customsnackErrorBar(context,"Email is not valid"));
                          }else{
                            overlayLoader(context);
                            _postRegisterUser(
                              email: _emailController.text,
                              phonenumber: _phoneNumberController.text,
                              username: _usernameController.text,
                            );
                          }

                        },
                        btnText: "Send OTP",
                        vertical: 20,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
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
                                text: 'Already a zeropay user?',
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' Login ',
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
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
