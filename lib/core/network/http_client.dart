import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dio_connectivity_request_retrier.dart';
import 'retry_interceptor.dart';

class HttpClient {
  final SharedPreferences sp;

  HttpClient({this.sp});

  Dio get dio => _getDio();

  var logger = Logger();

  Dio _getDio() {
    BaseOptions options = new BaseOptions(
      baseUrl: "https://reqres.in/api/",
      connectTimeout: 50000,
      receiveTimeout: 30000,
    );
    Dio dio = new Dio(options);
    dio.interceptors.addAll(<Interceptor>[_loggingInterceptor()]);
    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: Dio(),
          connectivity: Connectivity(),
        ),
      ),
    );

    return dio;
  }

  Interceptor _loggingInterceptor() {
    return InterceptorsWrapper(onRequest: (RequestOptions options) {
      // final accessToken = prefs.getString(Constant.accessToken);
      // final registerToken = prefs.getString(Constant.registerToken);

      logger.i(
          "--> ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl ?? "") + (options.path ?? "")}");
      logger.i("Headers:");
      options.headers.forEach((k, v) => print('$k: $v'));
      if (options.queryParameters != null) {
        logger.i("queryParameters:");
        options.queryParameters.forEach((k, v) => print('$k: $v'));
      }
      logger.i(
          "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");

      if (options.headers.containsKey('isToken')) {
        options.headers.remove('isToken');
        // options.headers.addAll({
        //   'Authorization':
        //       'Bearer ${registerToken != null ? registerToken : accessToken}'
        // });
      }
      // Do something before request is sent
      logger.i("\n"
          "-- headers --\n"
          "${options.headers.toString()} \n"
          "-- response --\n -->x"
          "${options.data} \n"
          "");

      return options; //continue
      // If you want to resolve the request with some custom data，
      // you can return a `Response` object or return `dio.resolve(data)`.
      // If you want to reject the request with a error message,
      // you can return a `DioError` object or return `dio.reject(errMsg)`
    }, onResponse: (Response response) {
      // Do something with response data
      // logger.i("\n"
      //     "Response : ${response.request.uri} \n"
      //     "-- headers --\n"
      //     "${response.headers.toString()} \n"
      //     "-- response --\n"
      //     "${JsonEncoder.withIndent('  ').convert(response.data)} \n"
      //     "");
      logger.i("${JsonEncoder.withIndent('  ').convert(response.data)} \n");
      return response; // continue
    }, onError: (DioError e) {
      // Do something with response error
      return e; //continue
    });
  }
}
