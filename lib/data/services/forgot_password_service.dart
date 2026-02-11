import 'dart:developer';
import 'package:get/get.dart';
import 'package:orioconnect/core/network/api_endpoints.dart';
import 'package:orioconnect/core/network/network_client.dart';
import 'package:orioconnect/data/models/forgot_password_model.dart';

class ForgotPasswordService {
  final NetworkClient _networkClient = Get.find();

  Future<ForgotPasswordResponseModel> forgotPassword({
    required String employeeEmail,
  }) async {
    try {
      final response = await _networkClient.post(
        endpoint: ApiConstants.forgotPasswordUrl,
        body: {'employee_email': employeeEmail},
      );
      log("Forgot Password Logs $response");
      return ForgotPasswordResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}