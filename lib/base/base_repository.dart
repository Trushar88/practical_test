// ignore_for_file: file_names, prefer_collection_literals

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:practical_test/app/config/api_const.dart';

import '../model/response_model.dart';
import '../app/config/app_strings.dart';

class BaseRepository {
  Dio? _dio;
  BaseRepository() {
    _dio = Dio(BaseOptions(
      baseUrl: APICONST.BASE_URL,
      connectTimeout: const Duration(seconds: 5), // set connecttimeout time
      receiveTimeout: const Duration(seconds: 5), // set receiveTimeout time
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "GET,POST, OPTIONS"
      },
    ));
    initInterceptor();
  }
  BaseRepository get to => BaseRepository();

  //Global header pass it in all API
  Future<Map<String, String>> getApiHeaders(bool authorizationRequired) async {
    Map<String, String> apiHeader = Map<String, String>();
    if (authorizationRequired) {
      apiHeader.addAll({"Authorization": APPSTRING.APP_NAME});
    } else {
      apiHeader.addAll({"Authorization": APPSTRING.APP_NAME});
    }
    apiHeader.addAll({"Content-Type": "application/json"});
    apiHeader.addAll({"Accept": "application/json"});
    log(apiHeader.toString());
    return apiHeader;
  }

  dynamic getAPIResult<T>(final response, T recordList) {
    try {
      dynamic result;
      result = APIResult.fromJson(response, recordList); // decode API response and bind it to our result class
      return result;
    } catch (e) {
      log("Exception - getAPIResult():$e");
    }
  }

  Dio getDio() => _dio!;

  initInterceptor() {
    _dio!.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      // Do something with response data
      // log("Response: "+response.data.toString());
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      // Do something with response error
      return handler.next(e); //continue
    }));

    _dio!.interceptors.add(LogInterceptor(request: true, requestHeader: true, requestBody: true, responseBody: true, error: true));
  }
}
