
import 'package:client/apis/authapi.dart';
import 'package:client/helpers/dioheaders.dart';
import 'package:client/helpers/headers.dart';
import 'package:client/screens/home/home.dart';

class SearchAPI {


  Future<void> getSearchResults({required BuildContext context,required String query}) async {
    var bearerToken = await flutterSecureStorage.read(key: "BEARERTOKEN");
    dio.options.headers["authorization"] = "Bearer $bearerToken";

     try {
      Response response = await dio.get("$SEARCH_URL?query=$query",options : dioOptions);
      if(response.statusCode == 200) {
        Loader.hide();
        print(response.data);
        return response.data['BODY'];
      }
    } on DioError catch (e) {
      Loader.hide();
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
