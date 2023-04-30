

import 'package:client/helpers/headers.dart';
import 'package:client/screens/auth/login.dart';

class SplashInfo extends StatelessWidget {
  static const routeName = splashinfo;
  const SplashInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = sizeMedia(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              margin: EdgeInsets.symmetric(
                horizontal: kScreenMarginHorizontal(context),
                vertical: 20.0,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultScreenPaddingHorizontal(context),
                vertical: kDefaultScreenPaddingVertical(context),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        'assets/images/logininfo.png',
                        height: size.height * 0.4,
                        // width:size.width  ,
                      ),
                    ),
                    //SizedBox(height: isMobile(context) ? 30.0 : 35.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                            Text(
                      'Revolutionize',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: isMobile(context) ? 27.0 : 32.0,
                          fontWeight: FontWeight.w900,
                          color: kTitleColor,
                          fontFamily: kQuickSandBold),
                    ),
                     Text(
                      'your',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: isMobile(context) ? 27.0 : 32.0,
                          fontWeight: FontWeight.w900,
                          color: kTitleColor,
                          fontFamily: kQuickSandBold),
                    ),
                     Text(
                      'payments',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: isMobile(context) ? 27.0 : 32.0,
                          fontWeight: FontWeight.w900,
                          color: kTitleColor,
                          fontFamily: kQuickSandBold),
                    ),
                    mediumCustomSizedBox(context),
                    defaultDivider(),
                        ],
                      ),
                    mediumCustomSizedBox(context),
                    mediumCustomSizedBox(context),
                    primaryBtn(context: context, onTap: () => Navigator.push(
                          context,
                          CustomRightPageRoute(
                              page: const LoginPage(),
                              routeName: loginpage)), btnText: "Start Pay", isOutline: false),
                   
                      ],
                    )
                   
                  ]),
            )));
  }
}
