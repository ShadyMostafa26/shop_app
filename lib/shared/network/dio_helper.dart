import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    String lang = 'en',
    String token,
    @required String url,
    Map<String, dynamic> query,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

    return await dio.get(
      url,
      queryParameters: query,
    );
  }


  static Future<Response> postData({
    String lang = 'en',
    String token,
    @required String url,
    Map<String, dynamic> query,
    @required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }


  static Future<Response> updateData({
    String lang = 'en',
    String token,
    @required String url,
    Map<String, dynamic> query,
    @required Map<String, dynamic> data,
  })async{
    dio.options.headers = {
      'lang': lang,
      'Content-Type': 'application/json',
      'Authorization': token ?? '',
    };

   return await dio.put(
      url,
     queryParameters: query,
     data: data,
    );
  }
}
