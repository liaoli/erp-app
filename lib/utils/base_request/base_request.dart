import 'dart:async';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'base_url.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'base_response_interceptor.dart';
import 'base_request_log.dart';
import 'base_result_data.dart';
import 'base_request_error_code.dart';

class RequestUtil {
  static RequestUtil _instance = RequestUtil._internal();

  Dio dio;
  static const CODE_SUCCESS = 200;
  static const CODE_TIME_OUT = -1;

  factory RequestUtil() => _instance;
  RequestUtil._internal() {
    if (dio == null) {
      dio = new Dio(
        BaseOptions(
            baseUrl: SERVER_HOST_URL,
            // 连接服务器超时时间，单位是毫秒.
            connectTimeout: 15000,
            // 响应流上前后两次接受到数据的间隔，单位为毫秒。
            receiveTimeout: 5000,
            contentType: 'application/json; charset=utf-8',
            responseType: ResponseType.json),
      );

      dio.interceptors.add(new DioLogInterceptor());
//      _dio.interceptors.add(new PrettyDioLogger());
      dio.interceptors.add(new ResponseInterceptors());

      // https证书认证
      if (SERVER_HOST_URL.contains('https')) {
        certificateHttps();
      }
    }
  }
  static RequestUtil getInstance({String baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  // 用于指定特定域名
  RequestUtil _baseUrl(String baseUrl) {
    if (dio != null) {
      dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  // 默认域名
  RequestUtil _normal() {
    if (dio != null) {
      if (dio.options.baseUrl != SERVER_HOST_URL) {
        dio.options.baseUrl = SERVER_HOST_URL;
      }
    }
    return this;
  }

  // https证书认证
  certificateHttps() {
    rootBundle.loadString('assets/certificate/jpshop.pem').then((value) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          if (cert.pem == value) {
            return true;
          }
          return false;
        };
      };
    });
  }

  /// get 操作
  Future get(String path, {dynamic params, Options options}) async {
    // 添加请求头
    Options requestOptions = addDatasToHeader(options);
    Response response;
    try {
      response =
          await dio.get(path, queryParameters: params, options: requestOptions);
    } on DioError catch (e) {
      return resultError(e);
    }

    if (response.data is DioError) {
      return resultError(response.data['code']);
    }

    return response.data;
  }

  ///  post 操作
  Future post(String path, {dynamic params, Options options}) async {
    // 添加请求头
    Options requestOptions = addDatasToHeader(options);

    Response response;
    try {
      response = await dio.post(path, data: params, options: requestOptions);
    } on DioError catch (e) {
      return resultError(e);
    }

    if (response.data is DioError) {
      return resultError(response.data['code']);
    }

    return response.data;
  }

  ///  put 操作
  Future put(String path, {dynamic params, Options options}) async {
    Options requestOptions = addDatasToHeader(options);

    var response = await dio.put(path, data: params, options: requestOptions);
    return response.data;
  }

  ///  patch 操作
  Future patch(String path, {dynamic params, Options options}) async {
    Options requestOptions = options ?? Options();
    var response = await dio.patch(path, data: params, options: requestOptions);
    return response.data;
  }

  /// delete 操作
  Future delete(String path, {dynamic params, Options options}) async {
    Options requestOptions = options ?? Options();
    var response =
        await dio.delete(path, data: params, options: requestOptions);
    return response.data;
  }

  ///  post form 表单提交操作
  Future postForm(String path, {dynamic params, Options options}) async {
    Options requestOptions = options ?? Options();
    var response = await dio.post(path,
        data: FormData.fromMap(params), options: requestOptions);
    return response.data;
  }
}

// 请求头添加数据
addDatasToHeader(Options options) {
  Options requestOptions = options ?? Options();
  // UserInfoManager shareUserInfo = UserInfoManager();
  // if (shareUserInfo.accessToken.isNotEmpty) {
  //   Map<String, dynamic> _authorization = {
  //     "Authorization": shareUserInfo.accessToken,
  //     "UserId": shareUserInfo.userId,
  //   };
  //   requestOptions = requestOptions.merge(headers: _authorization);
  // }

  return requestOptions;
}

ResultData resultError(DioError e) {
  Response errorResponse;
  if (e.response != null) {
    errorResponse = e.response;
  } else {
    errorResponse = new Response(statusCode: 0);
  }
  if (e.type == DioErrorType.CONNECT_TIMEOUT ||
      e.type == DioErrorType.RECEIVE_TIMEOUT) {
    errorResponse.statusCode = Code.NETWORK_TIMEOUT;
  }
  return new ResultData(
      errorResponse.statusMessage, false, errorResponse.statusCode);
}
