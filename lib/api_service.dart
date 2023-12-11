import 'dart:developer';

import 'package:dio/dio.dart';

class ApiService {
  Dio dioClient = Dio();
  ApiService() {
    initInstance();
  }

  void initInstance() {
    final dio = Dio();
    dio.options
      ..connectTimeout = const Duration(milliseconds: 30000)
      ..receiveTimeout = const Duration(milliseconds: 30000)
      ..responseType = ResponseType.json
      ..baseUrl = 'https://storage.googleapis.com/tpop-app-dev.appspot.com/';

    dio.interceptors.clear();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        log(
          '''onRequest ======================
          Path : ${options.path}
          Method  : ${options.method}''',
        );
        handler.next(options);
      },
      onResponse: (response, handler) {
        log("onResponse ======================\nStatusCode : ${response.statusCode} \nPath : ${response.requestOptions.path} \nMethod : ${response.requestOptions.method}");
        handler.next(response);
      },
      onError: (error, handler) {
        log("onError ======================\nError : ${error.error} \nPath : ${error.requestOptions.path} \nMethod : ${error.requestOptions.method}");
        handler.next(error);
      },
    ));

    dioClient = dio;
  }
}
