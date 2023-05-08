
import 'package:client/helpers/dioheaders.dart';
import 'package:client/helpers/headers.dart';
import 'package:client/screens/auth/login.dart';
import 'package:client/screens/auth/otppage.dart';
import 'package:client/screens/home/home.dart';

class AuthenticationAPI {
  //Initialize the plugin dio
  //Dio dio = new Dio(dioOptions);
  postLoginUser({required BuildContext context,required String phonenumber}) async {
    FormData data = FormData.fromMap({
      "number": phonenumber,
    });

    try {
      Response response = await dio.post(LOGIN_URL,options : dioInitialOptions,data : data);
      if(response.statusCode == 200) {
        print(response.data);
        ScaffoldMessenger.of(context).showSnackBar(customSnackSuccessBar(context, "OTP was sent successfully"));
        Loader.hide();
        return Navigator.push(context,CustomSimplePageRoute(page: OtpPage(pid: response.data['BODY']['pid'],phoneNumber: phonenumber,), routeName: otppage));
      }
    } on DioError catch (e) {
        Loader.hide();
        
        if(e.response?.statusCode == 404){
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Number does not exist.Try Sign Up"));
          return false;
        }
        else{
          print("Response Code is ${e.response?.statusCode}");
          print("${e.message} + ${e.type} in login api");
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Oops! An unknown error occured. Please try again later."));
          return false;
        }   
    }
  }


  postOtpVerification({required BuildContext context,required String otp,required String pid}) async {
    FormData data = FormData.fromMap({
      "otp" : otp,
      "pid" : pid
    });

    try {
      
      Response response = await dio.post(VERIFY_OTP_URL,options : dioInitialOptions,data : data);
      if(response.statusCode == 200){
        print(response.data);
        Loader.hide();
        var bearerToken = response.data['BODY']['pid'];
        await flutterSecureStorage.write(key: "BEARERTOKEN", value: bearerToken);
        return Navigator.pushReplacement(context, CustomSimplePageRoute(page: HomePage(), routeName: homepage));
      }
    } on DioError catch (e) {
        Loader.hide();
        if(e.response?.statusCode == 400){
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "OTP expired.Try again"));
          return false;
        }else if(e.response?.statusCode == 406){
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "The OTP entered was incorrect.Try again"));
          return false;
        }
        else{
          print("Response Code is ${e.response?.statusCode}");
          print("${e.message} + ${e.type} in login api");
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Oops! An unknown error occured. Please try again later."));
          return false;
        }   
    }
  }

  postRegisterUser({required BuildContext context,required String userName,required String phonenumber,required String email}) async {
    FormData data = FormData.fromMap({
      "number": phonenumber,
      "username" : userName,
      "email" : email
    });

    try {
      Response response = await dio.post(REGISTER_URL,options : dioInitialOptions,data : data);
      if(response.statusCode == 200) {
        print(response.data);
        ScaffoldMessenger.of(context).showSnackBar(customSnackSuccessBar(context, "OTP was sent successfully"));
        Loader.hide();
        return Navigator.push(context,CustomSimplePageRoute(page: OtpPage(pid: response.data['BODY']['pid'],phoneNumber: phonenumber,), routeName: otppage));
      }
    } on DioError catch (e) {
      Loader.hide();
        if(e.response?.statusCode == 409){
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Number already exists.Try with new number"));
          return false;
        }
        else if(e.response?.statusCode == 406){
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "The current email is a breached email. Try new email"));
          return false;
        }
        else{
          print("Response Code is ${e.response?.statusCode}");
          print("${e.message} + ${e.type} in login api");
          ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context, "Oops! An unknown error occured. Please try again later."));
          return false;
        }   
    }
  }

 performLogOut(BuildContext context)async{
    await flutterSecureStorage.delete(key: "BEARERTOKEN");
    return Navigator.pushReplacement(context, CustomSimplePageRoute(page: LoginPage(), routeName: loginpage));
  }

}
