import 'package:client/helpers/headers.dart';
import 'package:client/screens/auth/login.dart';
import 'package:client/screens/auth/otppage.dart';
import 'package:client/screens/auth/personal.dart';
import 'package:client/screens/auth/registerpage.dart';
import 'package:client/screens/auth/splash.dart';
import 'package:client/screens/home/addcard.dart';
import 'package:client/screens/home/cardlist.dart';
import 'package:client/screens/home/checkbalance.dart';
import 'package:client/screens/home/home.dart';
import 'package:client/screens/home/notifications.dart';
import 'package:client/screens/home/paypin.dart';
import 'package:client/screens/home/peopletransaction.dart';
import 'package:client/screens/home/profile.dart';
import 'package:client/screens/home/scanqr.dart';
import 'package:client/screens/home/sendmoney.dart';
import 'package:client/screens/home/setuppin.dart';
import 'package:client/screens/home/test.dart';
import 'package:client/screens/home/transactions.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    //This screen is used when it causes red screen error
  //   ErrorWidget.builder = (FlutterErrorDetails details) {
  //     //TODO:To change the UI
  //   return Material(
  //     child: Container(
  //       color: Colors.white,
  //       alignment: Alignment.center,
  //       padding: EdgeInsets.all(30),
  //       child: Column(
  //         children: [
  //           Expanded(
  //             flex: 2,
  //             child: Image.asset("assets/images/error.png",fit: BoxFit.contain,height: double.infinity,width: double.infinity,)),
  //           Expanded(
  //             flex: 1,
  //             child: RichText(
  //                       textAlign: TextAlign.center,
  //                       text: TextSpan(children: <TextSpan>[
  //                         TextSpan(
  //                             text: 'This page caused an unexpected ',
  //                             style: TextStyle(color: kPrimaryColor)),
  //                         TextSpan(
  //                             text: ' ERROR. ',
  //                             style: TextStyle(
  //                                 color: kRedColor,
  //                                 fontWeight: FontWeight.bold)),
  //                         TextSpan(
  //                             text: ' Try again...',
  //                             style: TextStyle(color: kPrimaryColor)),
  //                       ]),
  //                     ),
  //           )
  //         ],
  //       )
  //     ),
  //   );
  // };
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    final _flutterSecureStorage = const FlutterSecureStorage();
  
  @override
    void initState() {
      super.initState();
      getStoredAccessTokenOrEmpty;
    }   

  Future<String> get getStoredAccessTokenOrEmpty async {
    var _userBearerToken = await _flutterSecureStorage.read(key: "BEARERTOKEN");
    if(_userBearerToken == null) return "";
    return _userBearerToken;
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Square Pay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      home:FutureBuilder(
        future: getStoredAccessTokenOrEmpty,
        builder: (context,snapshot) {
           if(!snapshot.hasData) return customCircularProgress() ;
          if(snapshot.data != ""){
            return  const HomePage();
          }else{
            return const SplashInfo();
            //SendMoneyPage(recImg: "https://pbs.twimg.com/profile_images/1485050791488483328/UNJ05AV8_400x400.jpg",recName: "Karthi A",recPhone: "8097567892",recPid: "",); //AppScreenController(indexScreen:)
          }
        },
      ),
      routes: {
        //Auth Screens
        SplashInfo.routeName: (context) => const SplashInfo(), //Path : /loginpage
        LoginPage.routeName: (context) => const LoginPage(), //Path : /loginpage
        RegisterPage.routeName: (context) => const RegisterPage(), //Path : /loginpage
        OtpPage.routeName: (context) => OtpPage(phoneNumber: "",pid: ""), //Path : /loginpage
        HomePage.routeName: (context) => HomePage(), //Path : /loginpage
        AddCardPage.routeName: (context) => const AddCardPage(), //Path : /loginpage
        AllCardPage.routeName: (context) => const AllCardPage(), //Path : /loginpage
        MyProfilePage.routeName: (context) => const MyProfilePage(), //Path : /loginpage
        SetupPinPage.routeName: (context) => const SetupPinPage(isPinSetup: true), //Path : /loginpage
        AllTransactions.routeName: (context) => const AllTransactions(), //Path : /loginpage
        NotificationPage.routeName: (context) => const NotificationPage(), //Path : /loginpage
        PeopleTransactionPage.routeName: (context) => const PeopleTransactionPage(toPid: ""), //Path : /loginpage
        PersonalInfoPage.routeName: (context) => const PersonalInfoPage(), //Path : /loginpage
        SearchPeoplePage.routeName: (context) => SearchPeoplePage(isOneTimePop: false,isMobileNumber: false), //Path : /loginpage
        SendMoneyPage.routeName: (context) => const SendMoneyPage(recImg: "",recName: "",recPhone: "",recPid: ""), //Path : /loginpage
        PayPinPage.routeName: (context) => const PayPinPage(recAmt: "",recPid: ""), //Path : /loginpage
        ScanQrPage.routeName: (context) => const ScanQrPage(), //Path : /loginpage
        CheckBalancePage.routeName: (context) => const CheckBalancePage(), //Path : /loginpage
      },
    );
  }
}