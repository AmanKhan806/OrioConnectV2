import 'dart:developer';
import 'package:get/get.dart';
import 'package:orioconnect/core/network/api_endpoints.dart';
import 'package:orioconnect/core/network/network_client.dart';
import 'package:orioconnect/data/models/logout_model.dart';

class LogoutService {
  final NetworkClient _networkClient = Get.find();

  Future<LogoutModel> logoutApi({required String userid}) async {
    try {
      final response = await _networkClient.post(
        endpoint: ApiConstants.logoutUrl,
        body: {'userid': userid},
      );
      log("Logout Logs $response");
      return LogoutModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
