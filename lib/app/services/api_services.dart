// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
// import 'package:ahavaplan_admin/utilities/app_util.dart';
import 'package:dio/dio.dart';
import 'package:fleet_app/app/controller/global_controller.dart';
import 'package:fleet_app/app/data/api_response.dart';
import 'package:fleet_app/app/data/constant.dart';
import 'package:fleet_app/app/services/api_interceptor.dart';
import 'package:fleet_app/app/services/logger_service.dart';
import 'package:fleet_app/app/shared/app_util.dart';
import 'package:flutter/material.dart';
import 'package:fleet_app/app/modules/login/controllers/login_controller.dart'
    as login_controller;
import 'package:get/get.dart' as getx;
// import 'package:get/get.dart';

var log = getLogger('ApiServices');

final controller = GlobalGetController.gbMasterController;

const String _baseUrl = 'https://api.fleetdb.xyz/api/v1';

var options = BaseOptions(
  baseUrl: _baseUrl,
);

Dio _dio = Dio(options);

Dio init() {
  Dio dio = _dio;
  dio.interceptors.add(DioInterceptor());
  dio.options.baseUrl = _baseUrl;
  return dio;
}

dynamic _jsonEncodeDateHandler(dynamic item) {
  if (item is DateTime) {
    return item.toIso8601String();
  }
  return item;
}

String serializeBody(dynamic body) {
  return jsonEncode(body, toEncodable: _jsonEncodeDateHandler);
}

class ApiServices {
  ApiServices() {
    init();
  }

  static Future<ApiResponse<T>> authPostApi<T>(
    String url,
    dynamic body, {
    Map<String, dynamic>? params,
    T Function(dynamic)? transform,
  }) async {
    transform ??= (dynamic r) => r.body as T;
    params ??= <String, dynamic>{};
    final ApiResponse<T> apiResponse = ApiResponse<T>();
    try {
      Response response = await _dio.post(url,
          options: Options(
            validateStatus: (_) => true,
          ),
          data: serializeBody(body),
          queryParameters: params);

      final dynamic data = response.data;
      debugPrint(
          "ENDPOINT : ${response.requestOptions.baseUrl}${response.requestOptions.path}");
      debugPrint("STATUSCODE : ${response.statusCode}");
      debugPrint("REQUEST: ${response.requestOptions.data}");
      debugPrint("RESPONSE: ${response.data}");
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        apiResponse.status = true;
        apiResponse.data = transform(data);
        apiResponse.message = data['message'];
      } else {
        if (response.statusCode == 203) {
          apiResponse.status = true;
          apiResponse.message = data['auth_status'];
        } else {
          apiResponse.status = false;
          apiResponse.message = data['message'];
        }
      }
    } catch (e) {
      //log.w("Error on catch block:-> $e");
      apiResponse.status = false;
      apiResponse.message = ErrorStatus.codeError;
    }
    return apiResponse;
  }

  static Future<ApiResponse<T>> getApi<T>(
    String url,
    dynamic body, {
    bool useToken = true,
    bool switchBaseUrl = false,
    Map<String, dynamic>? params,
    T Function(dynamic)? transform,
  }) async {
    transform ??= (dynamic r) => r.body as T;
    params ??= <String, dynamic>{};
    final ApiResponse<T> apiResponse = ApiResponse<T>();
    try {
      final token = getx.Get.find<login_controller.LoginController>()
          .loginPayload
          .value
          ?.data
          ?.accessToken;
      Response response;
      if (switchBaseUrl == false) {
        response = useToken
            ? await _dio.get(url,
                options: Options(
                  headers: {
                    'Authorization': 'Bearer $token',
                  },
                  validateStatus: (_) => true,
                ),
                queryParameters: params)
            : await _dio.get(url,
                options: Options(
                  validateStatus: (_) => true,
                ),
                queryParameters: params);
      } else {
        response = useToken
            ? await _dio.get(url,
                options: Options(
                  headers: {
                    'Authorization': 'Bearer $token',
                  },
                  validateStatus: (_) => true,
                ),
                queryParameters: params)
            : await _dio.get(url,
                options: Options(
                  validateStatus: (_) => true,
                ),
                queryParameters: params);
      }

      //log.d("response.statusCode : ${response.statusCode}");
      final dynamic data = response.data;
      debugPrint(
          "ENDPOINT : ${response.requestOptions.baseUrl}${response.requestOptions.path}");
      debugPrint("STATUSCODE : ${response.statusCode}");
      debugPrint("REQUEST: ${response.requestOptions.data}");
      debugPrint("RESPONSE: ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        apiResponse.status = true;
        apiResponse.data = transform(data);
        apiResponse.message = data['message'];
      } else if (response.statusCode == 401) {
        // navigationService.replaceWithSignIn();
        AppUtil.showSnackBar(
            text: 'Login session expired, kindly login again', error: true);
      } else {
        apiResponse.status = false;
        apiResponse.message = data['message'];
      }
    } catch (e) {
      log.w("Error on catch block:-> $e");
      apiResponse.status = false;
      apiResponse.message = ErrorStatus.codeError;
    }
    return apiResponse;
  }

  static Future<ApiResponse<T>> patchApi<T>(
    String url,
    dynamic body, {
    Map<String, dynamic>? params,
    T Function(dynamic)? transform,
  }) async {
    transform ??= (dynamic r) => r.body as T;
    params ??= <String, dynamic>{};
    final ApiResponse<T> apiResponse = ApiResponse<T>();
    try {
      // final token = _persistentStorageService.getToken;
      final token = getx.Get.find<login_controller.LoginController>()
          .loginPayload
          .value
          ?.data
          ?.accessToken;
      Response response = await _dio.patch(url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
            validateStatus: (_) => true,
          ),
          queryParameters: params,
          data: body);
      //log.d("response.statusCode : ${response.statusCode}");
      final dynamic data = response.data;
      debugPrint(
          "ENDPOINT : ${response.requestOptions.baseUrl}${response.requestOptions.path}");
      debugPrint("STATUSCODE : ${response.statusCode}");
      debugPrint("REQUEST: ${response.requestOptions.data}");
      debugPrint("RESPONSE: ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        apiResponse.status = true;
        apiResponse.data = transform(data);
        apiResponse.message = data['message'];
      } else {
        apiResponse.status = false;
        apiResponse.message = data['message'];
      }
    } catch (e) {
      //log.w("Error on catch block:-> $e");
      apiResponse.status = false;
      apiResponse.message = ErrorStatus.codeError;
    }
    return apiResponse;
  }

  static Future<ApiResponse<T>> putApi<T>(
    String url,
    dynamic body, {
    Map<String, dynamic>? params,
    bool switchBaseUrl = false,
    T Function(dynamic)? transform,
  }) async {
    transform ??= (dynamic r) => r.body as T;
    params ??= <String, dynamic>{};
    final ApiResponse<T> apiResponse = ApiResponse<T>();
    try {
      // final token = _persistentStorageService.getToken;
      final token = getx.Get.find<login_controller.LoginController>()
          .loginPayload
          .value
          ?.data
          ?.accessToken;
      Response response;
      if (switchBaseUrl == false) {
        response = await _dio.put(url,
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
              validateStatus: (_) => true,
            ),
            queryParameters: params,
            data: body);
      } else {
        response = await _dio.put(url,
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
              validateStatus: (_) => true,
            ),
            queryParameters: params,
            data: body);
      }

      //log.d("response.statusCode : ${response.statusCode}");
      final dynamic data = response.data;
      debugPrint(
          "ENDPOINT : ${response.requestOptions.baseUrl}${response.requestOptions.path}");
      debugPrint("STATUSCODE : ${response.statusCode}");
      debugPrint("REQUEST: ${response.requestOptions.data}");
      debugPrint("RESPONSE: ${response.data}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        apiResponse.status = true;
        apiResponse.data = transform(data);
        apiResponse.message = data['message'];
      } else {
        apiResponse.status = false;
        apiResponse.message = data['message'].toString();
      }
    } catch (e) {
      //log.w("Error on catch block:-> $e");
      apiResponse.status = false;
      apiResponse.message = ErrorStatus.codeError;
    }
    return apiResponse;
  }

  static Future<ApiResponse<T>> postApi<T>(
    String url,
    dynamic body, {
    Map<String, dynamic>? params,
    bool switchBaseUrl = false,
    T Function(dynamic)? transform,
  }) async {
    transform ??= (dynamic r) => r.body as T;
    params ??= <String, dynamic>{};
    final ApiResponse<T> apiResponse = ApiResponse<T>();
    try {
      final token = getx.Get.find<login_controller.LoginController>()
          .loginPayload
          .value
          ?.data
          ?.accessToken;
      Response response;
      if (switchBaseUrl == false) {
        response = await _dio.post(url,
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
              validateStatus: (_) => true,
            ),
            data: serializeBody(body),
            queryParameters: params);
      } else {
        response = await _dio.post(url,
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
              validateStatus: (_) => true,
            ),
            data: serializeBody(body),
            queryParameters: params);
      }

      //log.d("response.statusCode : ${response.statusCode}");
      final dynamic data = response.data;
      debugPrint(
          "ENDPOINT : ${response.requestOptions.baseUrl}${response.requestOptions.path}");
      debugPrint("STATUSCODE : ${response.statusCode}");
      debugPrint("REQUEST: ${response.requestOptions.data}");
      debugPrint("RESPONSE: ${response.data}");
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        apiResponse.status = true;
        apiResponse.data = transform(data);
        apiResponse.message = data['message'];
      } else {
        apiResponse.status = false;
        apiResponse.message = data['message'];
      }
    } catch (e) {
      //log.w("Error on catch block:-> $e");
      apiResponse.status = false;
      apiResponse.message = ErrorStatus.codeError;
    }
    return apiResponse;
  }

  static Future<ApiResponse<T>> deleteApi<T>(
    String url,
    dynamic body, {
    Map<String, dynamic>? params,
    bool switchBaseUrl = false,
    T Function(dynamic)? transform,
  }) async {
    transform ??= (dynamic r) => r.body as T;
    params ??= <String, dynamic>{};
    final ApiResponse<T> apiResponse = ApiResponse<T>();
    try {
      // final token = _persistentStorageService.getToken;
      final token = getx.Get.find<login_controller.LoginController>()
          .loginPayload
          .value
          ?.data
          ?.accessToken;
      Response response;
      if (switchBaseUrl == false) {
        response = await _dio.delete(url,
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
              validateStatus: (_) => true,
            ),
            data: serializeBody(body),
            queryParameters: params);
      } else {
        response = await _dio.delete(url,
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
              validateStatus: (_) => true,
            ),
            data: serializeBody(body),
            queryParameters: params);
      }

      //log.d("response.statusCode : ${response.statusCode}");
      final dynamic data = response.data;
      debugPrint(
          "ENDPOINT : ${response.requestOptions.baseUrl}${response.requestOptions.path}");
      debugPrint("STATUSCODE : ${response.statusCode}");
      debugPrint("REQUEST: ${response.requestOptions.data}");
      debugPrint("RESPONSE: ${response.data}");
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        apiResponse.status = true;
        apiResponse.data = transform(data);
        apiResponse.message = data['message'];
      } else {
        apiResponse.status = false;
        apiResponse.message = data['message'];
      }
    } catch (e) {
      //log.w("Error on catch block:-> $e");
      apiResponse.status = false;
      apiResponse.message = ErrorStatus.codeError;
    }
    return apiResponse;
  }
}
