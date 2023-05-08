import 'package:client/helpers/headers.dart';
import 'package:dio/dio.dart';

Dio dio = Dio();

const flutterSecureStorage = FlutterSecureStorage();


//BaseOptions
Options dioOptions = Options(
    receiveTimeout: 10 * 1000,
    receiveDataWhenStatusError: true,
    sendTimeout: 10 * 1000,
    headers: {
      'Content-Type': "application/json",
      "Access-Control-Allow-Origin": "*",
     
    });

//BaseOptions
Options dioInitialOptions = Options(
    receiveTimeout: 10 * 1000,
    receiveDataWhenStatusError: true,
    sendTimeout: 10 * 1000,
    headers: {
      'Content-Type': "application/json",
      "Access-Control-Allow-Origin": "*",
    });


/*
BaseOptions dioOptions = new BaseOptions(
    connectTimeout: 10 * 1000, //30 seconds
    receiveTimeout: 10 * 1000,
    receiveDataWhenStatusError: true,
    headers: {
      'Content-Type': "application/json",
      "Access-Control-Allow-Origin": "*",
      "Authorization": "Bearer $token"
    }); */
