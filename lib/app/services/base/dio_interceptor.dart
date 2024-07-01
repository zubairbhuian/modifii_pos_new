import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base/app/utils/logger.dart';

import 'preferences.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    /// add token to header if user is logged in
    // final token = Preferences.token;
    // if (token.isNotEmpty) {
    //   // options.headers['access-token'] =token;
    //   // options.headers['Authorization'] = 'Bearer $token';
    // }

    /// set options
    options.validateStatus = (_) => true;
    options.receiveDataWhenStatusError = true;
    options.responseType = ResponseType.json;

    if (kDebugMode) {
      kLogger.d('URL: ${options.method} ${options.uri}');
      kLogger.i("Header: ${options.headers}");
      kLogger.i("Body: ${options.data}");
      kLogger.i("QueryParameters ${options.queryParameters}");
      if (options.data is FormData) {
        final formData = options.data as FormData;
        for (var element in formData.files) {
          kLogger.i("${element.key}:::${element.value.filename}");
        }
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      final token = response.data['token'];
      if (token != null && token is String) {
        Preferences.token = token;
      }
    }
    if (kDebugMode) {
      kLogger.d('Response: ${response.statusCode} ${response.statusMessage}');
      kLogger.d(response.data);
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      kLogger.e('Error: ${err.message}');
    }
    super.onError(err, handler);
  }
}
