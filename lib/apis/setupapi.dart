import 'package:client/apis/authapi.dart';
import 'package:client/helpers/dioheaders.dart';
import 'package:client/helpers/headers.dart';
import 'package:client/screens/auth/login.dart';
import 'package:client/screens/auth/otppage.dart';
import 'package:client/screens/home/home.dart';

class SetupPinAPI {

   postSetupPin({required BuildContext context,required String newPin,required String oldPin}) async {
    FormData data = FormData.fromMap({
      "old_pin": oldPin,
      "new_pin": newPin
    });

    var bearerToken = await flutterSecureStorage.read(key: "BEARERTOKEN");
    dio.options.headers["authorization"] = "Bearer $bearerToken";
    
    try {
      Response response =
          await dio.post(SETUP_PIN_URL, options: dioOptions, data: data);
      if (response.statusCode == 200) {
        print(response.data);
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackSuccessBar(context, "Transaction Pin Changed Successfully"));
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
        print("${e.message} + ${e.type} in login api");
        ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context,
            "Oops! An unknown error occured. Please try again later."));
        return false;
      }
    }
  }


   postAddCard({required BuildContext context,required String cardNumber,required String expiryMonth,required String cardCvv,required String cardHolder}) async {
    FormData data = FormData.fromMap({
      "card_number": cardNumber,
      "expiry_month": expiryMonth,
      "cvv": cardCvv,
      "card_holder_name" : cardHolder
    });

    var bearerToken = await flutterSecureStorage.read(key: "BEARERTOKEN");
    dio.options.headers["authorization"] = "Bearer $bearerToken";
    
    try {
      Response response =
          await dio.post(ADD_CARD_URL, options: dioOptions, data: data);
      if (response.statusCode == 200) {
        print(response.data);
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackSuccessBar(context, "Card is under verification. Please wait for 24 hours to get it verified"));
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
        print("${e.message} + ${e.type} in login api");
        ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context,
            "Oops! An unknown error occured. Please try again later."));
        return false;
      }
    }
  }


   postUpdateCard({required BuildContext context,required String cardNumber}) async {
    FormData data = FormData.fromMap({
      "card_number": cardNumber
    });

    var bearerToken = await flutterSecureStorage.read(key: "BEARERTOKEN");
    dio.options.headers["authorization"] = "Bearer $bearerToken";
    
    try {
      Response response =
          await dio.post(UPDATE_CARD_URL, options: dioOptions, data: data);
      if (response.statusCode == 200) {
        print(response.data);
        ScaffoldMessenger.of(context).showSnackBar(
            customSnackSuccessBar(context, "Card has been updated successfully"));
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
        print("${e.message} + ${e.type} in login api");
        ScaffoldMessenger.of(context).showSnackBar(customsnackErrorBar(context,
            "Oops! An unknown error occured. Please try again later."));
        return false;
      }
    }
  }

}
