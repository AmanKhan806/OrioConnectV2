import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:orioconnect/core/connectivity/connectivity_service.dart';
import 'package:orioconnect/core/network/api_endpoints.dart';
import 'package:orioconnect/core/network/api_interceptor.dart';
import '../exceptions/app_exceptions.dart';
import '../exceptions/exception_handler.dart';

class NetworkClient {
  late Dio _dio;
  final ConnectivityService _connectivityService = Get.find();

  NetworkClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(ApiInterceptor());
  }

  Future<Response> post({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    bool showErrorSnackbar = true,
  }) async {
    try {
      if (!_connectivityService.isConnected) {
        throw NoInternetException();
      }
      final options = Options(headers: _buildHeaders(headers));
      final response = await _dio.post(endpoint, data: body, options: options);
      log("Final Response:: $response");
      return response;
    } catch (e) {
      log("Final Error:: $e");
      throw ExceptionHandler.handleError(e, showSnackbar: showErrorSnackbar);
    }
  }

  Future<Response> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool showErrorSnackbar = true,
  }) async {
    try {
      if (!_connectivityService.isConnected) {
        throw NoInternetException();
      }

      final options = Options(headers: _buildHeaders(headers));

      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );

      return response;
    } catch (e) {
      throw ExceptionHandler.handleError(e, showSnackbar: showErrorSnackbar);
    }
  }

  Future<Response> put({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    bool showErrorSnackbar = true,
  }) async {
    try {
      if (!_connectivityService.isConnected) {
        throw NoInternetException();
      }

      final options = Options(headers: _buildHeaders(headers));

      final response = await _dio.put(endpoint, data: body, options: options);

      return response;
    } catch (e) {
      throw ExceptionHandler.handleError(e, showSnackbar: showErrorSnackbar);
    }
  }

  Future<Response> delete({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    bool showErrorSnackbar = true,
  }) async {
    try {
      if (!_connectivityService.isConnected) {
        throw NoInternetException();
      }

      final options = Options(headers: _buildHeaders(headers));

      final response = await _dio.delete(
        endpoint,
        data: body,
        options: options,
      );

      return response;
    } catch (e) {
      throw ExceptionHandler.handleError(e, showSnackbar: showErrorSnackbar);
    }
  }

  Map<String, dynamic> _buildHeaders(Map<String, dynamic>? customHeaders) {
    final headers = <String, dynamic>{};

    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }

    return headers;
  }
}
