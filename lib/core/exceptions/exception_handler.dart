import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:orioconnect/App/routes/app_routes.dart';
import 'package:orioconnect/Utils/Snackbar/custom_snackbar.dart';
import 'app_exceptions.dart';
import 'dart:io';

class ExceptionHandler {
  static AppException handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return TimeoutException('Request timeout. Please try again.');

        case DioExceptionType.badResponse:
          return _handleStatusCode(
            error.response?.statusCode,
            error.response?.data,
          );

        case DioExceptionType.cancel:
          return FetchDataException('Request was cancelled');

        case DioExceptionType.connectionError:
          return NoInternetException('No internet connection');

        default:
          return FetchDataException('Unexpected error occurred');
      }
    } else if (error is SocketException) {
      return NoInternetException('No internet connection');
    } else if (error is TimeoutException) {
      return TimeoutException('Request timeout');
    } else {
      return FetchDataException('Something went wrong');
    }
  }

  static AppException _handleStatusCode(int? statusCode, dynamic responseData) {
    String message = _extractMessage(responseData);

    switch (statusCode) {
      case 400:
        return BadRequestException(message);
      case 401:
        return UnauthorizedException(message); 
      case 404:
        return NotFoundException(message);
      case 500:
      case 502:
      case 503:
        return InternalServerException(message);
      default:
        return FetchDataException('Error occurred with status code: $statusCode');
    }
  }

  static String _extractMessage(dynamic responseData) {
    if (responseData is Map) {
      return responseData['message'] ??
          responseData['error'] ?? 
          responseData['msg'] ??
          'An error occurred';
    }
    return 'An error occurred';
  }

  static void showErrorSnackbar(AppException exception) {
    if (exception is UnauthorizedException) {
      customSnackBar("Login Failed", exception.message, snackBarType: SnackBarType.error);
      return;
    }

    if (exception.statusCode == 404) {
      Get.toNamed(AppRoutes.error404Route);
    } else if (exception is NoInternetException) {
      customSnackBar("No Internet", exception.message, snackBarType: SnackBarType.error);
    } else {
      customSnackBar("Error", exception.message, snackBarType: SnackBarType.error);
    }
  }
}
