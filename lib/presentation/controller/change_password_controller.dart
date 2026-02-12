import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orioconnect/App/routes/app_routes.dart';
import 'package:orioconnect/Utils/Snackbar/custom_snackbar.dart';
import 'package:orioconnect/data/services/change_password_service.dart';
import '../../Utils/CircularProgressIndicator/circular_progress_indicator.dart';
import '../../core/storage/secure_storage_service.dart';

class ChangePasswordController extends GetxController {
  final ChangePasswordService changePasswordService = Get.find();
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxBool hideOldPassword = true.obs;
  final RxBool hideNewPassword = true.obs;
  final RxBool hideConfirmPassword = true.obs;
  RxInt employeeId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadEmpId();
  }

  Future _loadEmpId() async {
    employeeId.value = await SecureStorageService.getEmployeeIdAsInt();
  }

  Future<void> changePassword(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (newPassword.text.trim() != confirmPassword.text.trim()) {
      customSnackBar(
        'Error',
        'New password and confirm password do not match',
        snackBarType: SnackBarType.error,
      );
      return;
    }
    if (oldPassword.text.trim() == newPassword.text.trim()) {
      customSnackBar(
        'Error',
        'New password cannot be same as current password',
        snackBarType: SnackBarType.error,
      );
      return;
    }
    isLoading.value = true;
    CustomLoadingDialog.show();
    try {
      final response = await changePasswordService.changePassword(
        employeeId: employeeId.value,
        oldPassword: oldPassword.text.trim(),
        newPassword: newPassword.text.trim(),
      );
      CustomLoadingDialog.hide();
      isLoading.value = false;
      if (response.isSuccess) {
        customSnackBar(
          'Success',
          response.message,
          snackBarType: SnackBarType.success,
        );
        clear();
        Get.toNamed(AppRoutes.menuRoute);
      } else {
        customSnackBar(
          'Error',
          response.message,
          snackBarType: SnackBarType.error,
        );
      }
    } catch (e) {
      log("Catch error:: $e");
      CustomLoadingDialog.hide();
      isLoading.value = false;
    } finally {
      CustomLoadingDialog.forceHide();
      isLoading.value = false;
    }
  }

  void clear() {
    employeeId.value = 0;
    oldPassword.clear();
    newPassword.clear();
    confirmPassword.clear();
  }

  @override
  void onClose() {
    employeeId.value = 0;
    oldPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}
