import 'dart:developer';
import 'package:get/get.dart';
import 'package:orioconnect/core/network/api_endpoints.dart';
import 'package:orioconnect/core/network/network_client.dart';
import 'package:orioconnect/data/models/change_password_model.dart';

class ChangePasswordService {
  final NetworkClient _networkClient = Get.find();

  Future<ChangePasswordModel> changePassword({
    required int employeeId,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _networkClient.post(
        endpoint: ApiConstants.changePasswordUrl,
        body: {'employee_id': employeeId, 'old_password': oldPassword, 'new_password': newPassword},
      );
      log("Change Password Logs $response");
      return ChangePasswordModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}