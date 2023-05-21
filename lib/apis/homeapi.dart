import 'package:client/apis/authapi.dart';
import 'package:client/helpers/dioheaders.dart';
import 'package:client/helpers/headers.dart';
import 'package:client/screens/auth/login.dart';
import 'package:client/screens/auth/otppage.dart';
import 'package:client/screens/home/home.dart';

class HomeScreenAPI {

  Future<void> getHomeScreen({required BuildContext context}) async {
    var bearerToken = await flutterSecureStorage.read(key: "BEARERTOKEN");
    dio.options.headers["authorization"] = "Bearer $bearerToken";
     try {
      Response response = await dio.get(HOME_URL,options : dioOptions);
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
        print("${e.message} + ${e.type} in appointments pending api");
        //Logout
        return defaultErrordialog(context: context, errorCode: ES_0040,);
      } 
    }
  }


  Future<void> getAllCards({required BuildContext context}) async {
    var bearerToken = await flutterSecureStorage.read(key: "BEARERTOKEN");
    dio.options.headers["authorization"] = "Bearer $bearerToken";
     try {
      Response response = await dio.get(GET_CARDS_URL,options : dioOptions);
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
        print("${e.message} + ${e.type} in appointments pending api");
        //Logout
        return defaultErrordialog(context: context, errorCode: ES_0040,);
      } 
    }
  }



  Future<void> getProfilePage({required BuildContext context}) async {
    var bearerToken = await flutterSecureStorage.read(key: "BEARERTOKEN");
    dio.options.headers["authorization"] = "Bearer $bearerToken";
     try {
      Response response = await dio.get(MY_PROFILE_URL,options : dioOptions);
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
        print("${e.message} + ${e.type} in appointments pending api");
        //Logout
        return defaultErrordialog(context: context, errorCode: ES_0040,);
      } 
    }
  }


  Future<void> getAllTransactions({required BuildContext context}) async {
    var bearerToken = await flutterSecureStorage.read(key: "BEARERTOKEN");
    dio.options.headers["authorization"] = "Bearer $bearerToken";
     try {
      Response response = await dio.get(ALL_TRANSACTIONS_URL,options : dioOptions);
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
        print("${e.message} + ${e.type} in appointments pending api");
        //Logout
        return defaultErrordialog(context: context, errorCode: ES_0040,);
      } 
    }
  }


  Future<void> getNotifications({required BuildContext context}) async {
    var bearerToken = await flutterSecureStorage.read(key: "BEARERTOKEN");
    dio.options.headers["authorization"] = "Bearer $bearerToken";
     try {
      Response response = await dio.get(NOTIFICATIONS_URL,options : dioOptions);
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
        print("${e.message} + ${e.type} in notify pending api");
        //Logout
        return defaultErrordialog(context: context, errorCode: ES_0040,);
      } 
    }
  }


  Future<void> getTransactionPeople({required BuildContext context,required String toPid}) async {
    var bearerToken = await flutterSecureStorage.read(key: "BEARERTOKEN");
    dio.options.headers["authorization"] = "Bearer $bearerToken";


     try {
      Response response = await dio.get("$TRANSACTION_PEOPLE?to_pid=$toPid",options : dioOptions);
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
        print("${e.message} + ${e.type} in notify pending api");
        //Logout
        return defaultErrordialog(context: context, errorCode: ES_0040,);
      } 
    }
  }


}
