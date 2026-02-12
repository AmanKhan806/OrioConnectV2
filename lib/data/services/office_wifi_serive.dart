import 'dart:developer';
import 'package:get/get.dart';
import 'package:orioconnect/core/network/api_endpoints.dart';
import 'package:orioconnect/core/network/network_client.dart';
import 'package:orioconnect/data/models/office_wifi_model.dart';

class OfficeWifiSerive {
  final NetworkClient _networkClient = Get.find();

  Future<OfficeWifiModel> officeWifiList() async {
    try {
      final response = await _networkClient.get(
        showErrorSnackbar: false,
        endpoint: ApiConstants.officeWifiUrl,
      );
      log("Office Wifi Logs $response");
      return OfficeWifiModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}