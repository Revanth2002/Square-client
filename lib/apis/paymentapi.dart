
import 'package:client/apis/authapi.dart';
import 'package:client/helpers/dioheaders.dart';
import 'package:client/helpers/headers.dart';
import 'package:client/screens/home/home.dart';
import 'package:client/screens/home/peopletransaction.dart';

class PaymentAPI {

   postSendMoney({required BuildContext context,required String pin,required String toPid,required String amount}) async {
    FormData data = FormData.fromMap({
      "to_pid": toPid,
      "amount": amount,
      "pin" : pin
    });

    var bearerToken = await flutterSecureStorage.read(key: "BEARERTOKEN");
    dio.options.headers["authorization"] = "Bearer $bearerToken";
    
    try {
      Response response =
          await dio.post(SEND_MONEY_URL, options: dioOptions, data: data);
      if (response.statusCode == 200) {
        print(response.data);
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackSuccessBar(context, "Money sent successfully"));
        Loader.hide();
        return Navigator.pushReplacement(context,
            CustomSimplePageRoute(page: const HomePage(),routeName: homepage));
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        Loader.hide();
        ScaffoldMessenger.of(context).showSnackBar(
            customsnackErrorBar(context, "${e.response?.data["ERR"]}"));
        return false;
      } else if (e.response?.statusCode == 406) {
        Loader.hide();
        ScaffoldMessenger.of(context).showSnackBar(
            customsnackErrorBar(context, "${e.response?.data["ERR"]}"));
        return false;
      } else {
        Loader.hide();
        print("Response Code is ${e.response?.statusCode}");
        print("${e.message} + ${e.type} in payment api");
        ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context,
            "Oops! An unknown error occured. Please try again later."));
        return false;
      }
    }
  }

   postQrScan({required BuildContext context,required String toPid}) async {
    FormData data = FormData.fromMap({
      "pid": toPid
    });

    var bearerToken = await flutterSecureStorage.read(key: "BEARERTOKEN");
    dio.options.headers["authorization"] = "Bearer $bearerToken";
    
    try {
      Response response =
          await dio.post(SCAN_QR_CHECKER, options: dioOptions, data: data);
      if (response.statusCode == 200) {
        print(response.data);
        // ScaffoldMessenger.of(context).showSnackBar(
        //     customSnackSuccessBar(context, "Money sent successfully"));
        Navigator.pop(context);
        Loader.hide();
        return Navigator.push(
          context,
          CustomRightPageRoute(
              page: PeopleTransactionPage(toPid: response.data['BODY']['pid'] ), routeName: peopletransactionpage));
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        Loader.hide();
        ScaffoldMessenger.of(context).showSnackBar(
            customsnackErrorBar(context, "${e.response?.data["ERR"]}"));
        return false;
      } else if (e.response?.statusCode == 406) {
        Loader.hide();
        ScaffoldMessenger.of(context).showSnackBar(
            customsnackErrorBar(context, "${e.response?.data["ERR"]}"));
        return false;
      } else {
        Loader.hide();
        print("Response Code is ${e.response?.statusCode}");
        print("${e.message} + ${e.type} in scan qr api");
        ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context,
            "Oops! An unknown error occured. Please try again later."));
        return false;
      }
    }
  }



  Future<void> checkCardBalance({required BuildContext context}) async {
    var bearerToken = await flutterSecureStorage.read(key: "BEARERTOKEN");
    dio.options.headers["authorization"] = "Bearer $bearerToken";


     try {
      Response response = await dio.get(CHECK_BALANCE_URL,options : dioOptions);
      if(response.statusCode == 200) {
        print(response.data);
        return response.data['BODY'];
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.sendTimeout) {
        //Send Timeout
        return defaultErrordialog(context: context, errorCode: ES_0052,onTapBtn: () => Navigator.of(context).pushReplacement(CustomSimplePageRoute(page: HomePage(),routeName: homepage)));
      } else if (e.type == DioErrorType.receiveTimeout) {
        //Receive timeout
        return defaultErrordialog(context: context, errorCode: ES_0054,onTapBtn: () => Navigator.of(context).pushReplacement(CustomSimplePageRoute(page: HomePage(),routeName: homepage)));
      } else if (e.type == DioErrorType.connectTimeout) {
        //When connection is taking too long or not connecting at all
        return defaultErrordialog(context: context, errorCode: ES_0051,onTapBtn: () => Navigator.of(context).pushReplacement(CustomSimplePageRoute(page: HomePage(),routeName: homepage)));  
      } else if(e.response?.statusCode == 401){
        //When anonymous user is requesting for data
        AuthenticationAPI().performLogOut(context);
        return defaultErrordialog(context: context, errorCode: ES_0041);
      } else if(e.response?.statusCode == 500){
        //Internal server error
        return defaultErrordialog(context: context, errorCode: ES_0050,onTapBtn: () => Navigator.of(context).pushReplacement(CustomSimplePageRoute(page: HomePage(),routeName: homepage)));
      } else if(e.response?.statusCode == 503){
        //When server is under maintenance
        //TODO : redirect to Maintenance page
        return null;
      }else {
        print("${e.message} + ${e.type} in balance api");
        //Logout
        return defaultErrordialog(context: context, errorCode: ES_0040,);
      } 
    }
  }



}
