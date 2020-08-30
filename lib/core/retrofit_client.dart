import 'package:dio/dio.dart';
import 'package:flutter_starter_app/utils/const.dart';


import 'data_service.dart';

class RetrofitClientInstance{
  static RetrofitClientInstance _instance = RetrofitClientInstance._internal();
  Dio _dio;
  GetDataService _client;

  RetrofitClientInstance._internal({mid = "", key = ""}){
    _dio = Dio();
    _dio.options.responseType = ResponseType.json;
    _dio.options.headers["accept"] = "application/json";
    _dio.options.headers["mid"] = mid;
    _dio.options.headers["key"] = key;
    _dio.options.connectTimeout = (3 * 60 * 1000);
    _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    _client = GetDataService(_dio, baseUrl:  Const.BASE_URL );
  }



  static RetrofitClientInstance getInstance() {
    return _instance;
  }

  GetDataService getDataService() {
    return _client;
  }

  void reset(String mid, String key) {
    _instance = RetrofitClientInstance._internal(mid: mid, key: key);
  }

}