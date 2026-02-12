import 'dart:developer';
import 'package:get/get.dart';
import 'package:orioconnect/core/network/api_endpoints.dart';
import 'package:orioconnect/core/network/network_client.dart';
import 'package:orioconnect/data/models/login_response_model.dart';
import 'package:orioconnect/data/models/otp_response_model.dart';

class LoginService {
  final NetworkClient _networkClient = Get.find();

  Future<LoginResponseModel> login({
    required String userId,
    required String password,
  }) async {
    try {
      final response = await _networkClient.post(
        endpoint: ApiConstants.loginUrl,
        body: {'username': userId, 'password': password},
      );
      log("login Logs $response");
      return LoginResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<OtpResponseModel> verifyOtp({
    required String username,
    required int otp,
  }) async {
    try {
      final body = {'username': username, 'otp': otp};
      log("OTP Request Body:: $body");
      final response = await _networkClient.post(
        endpoint: ApiConstants.verifyOtpUrl,
        body: body,
      );
      log("Otp Response:: $response");
      return OtpResponseModel.fromJson(response.data);
    } catch (e) {
      log("OTP Verification Error: $e");
      rethrow;
    }
  }
}
