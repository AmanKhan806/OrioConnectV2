import 'package:orioconnect/core/network/app_config_apikey.dart';

class ApiConstants {
  static final String baseUrl = AppConfig.apiKey;
  static final String loginUrl = '$baseUrl/auth/login';
  static final String verifyOtpUrl = '$baseUrl/auth/verify-otp';
  static final String forgotPasswordUrl = '$baseUrl/auth/forget-password';
  static final String logoutUrl = '$baseUrl/auth/logout';
}
