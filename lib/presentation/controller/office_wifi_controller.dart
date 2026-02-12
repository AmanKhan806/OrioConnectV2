import 'dart:developer';

import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:orioconnect/Utils/Snackbar/custom_snackbar.dart';
import 'package:orioconnect/data/models/office_wifi_model.dart';
import 'package:orioconnect/data/services/office_wifi_serive.dart';
import '../../Utils/CircularProgressIndicator/circular_progress_indicator.dart';

class OfficeWifiController extends GetxController {
  final OfficeWifiSerive officeWifiSerive = Get.find();
  final isLoading = false.obs;
  final RxList<OfficeWifiPayload> officeWifiList = <OfficeWifiPayload>[].obs;

  @override
  void onInit() {
    super.onInit();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      fetchOfficeWifiList();
    });
  }

  Future<void> fetchOfficeWifiList() async {
    CustomLoadingDialog.show();
    try {
      final response = await officeWifiSerive.officeWifiList();
      if (response.isSuccess && response.payload.isNotEmpty) {
        officeWifiList.value = response.payload;
      } else {
        officeWifiList.clear();
        customSnackBar(
          'Info',
          response.message.isNotEmpty
              ? response.message
              : 'No office wifi found',
          snackBarType: SnackBarType.info,
        );
      }
    } catch (e) {
      log("Office Wifi Error $e");
    } finally {
      CustomLoadingDialog.forceHide();
    }
  }
}
