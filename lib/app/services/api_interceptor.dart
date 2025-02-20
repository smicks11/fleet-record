// ignore_for_file: prefer_interpolation_to_compose_strings
import 'package:dio/dio.dart';
import 'package:fleet_app/app/services/logger_service.dart';
import 'package:flutter/material.dart';

class DioInterceptor extends Interceptor {
  final log = getLogger('DioInterceptor');

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint('ENDPOINT: ' + err.requestOptions.uri.toString());
    debugPrint('STATUSCODE: ' + err.error.toString());
    debugPrint('MESSAGE: ' + (err.response?.data ?? err.message).toString());
    if (err.response?.statusCode == 401) {
      // NavigationService.navigatorKey.currentContext?.go('/logoutPageView');
    }
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('METHOD: ' + options.method);
    debugPrint('ENDPOINT: ' + options.uri.toString());
    debugPrint('HEADERS: ' + options.headers.toString());
    debugPrint('DATA: ' + (options.data ?? options.queryParameters).toString());
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('ENDPOINT: ' + response.requestOptions.uri.toString());
    debugPrint('STATUSCODE: ' + response.statusCode.toString());
    debugPrint('DATA: ' + response.data.toString());
    if (response.statusCode == 401) {
      // NavigationService.navigatorKey.currentContext?.go('/logoutPageView');
    }
    super.onResponse(response, handler);
  }
}
