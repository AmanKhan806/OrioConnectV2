import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orioconnect/App/routes/app_routes.dart';
import 'package:orioconnect/Utils/Snackbar/custom_snackbar.dart';
import 'package:orioconnect/data/services/forgot_password_service.dart';

import '../../Utils/CircularProgressIndicator/circular_progress_indicator.dart';

class ForgotPasswordController extends GetxController {
  final ForgotPasswordService forgotPasswordService = Get.find();
  final TextEditingController userEmail = TextEditingController();
  final RxBool isLoading = false.obs;

  Future<void> forgotPassword(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (userEmail.text.trim().isEmpty) {
      customSnackBar(
        'Error',
        'Please enter user ID',
        snackBarType: SnackBarType.error,
      );
      return;
    }
    isLoading.value = true;
    CustomLoadingDialog.show();
    try {
      final response = await forgotPasswordService.forgotPassword(
        employeeEmail: userEmail.text.trim(),
      );
      CustomLoadingDialog.hide();
      isLoading.value = false;
      if (response.isSuccess) {
        customSnackBar(
          'Success',
          response.message,
          snackBarType: SnackBarType.success,
        );
        Get.toNamed(AppRoutes.loginRoute);
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
      customSnackBar(
        'Error',
        'Something went wrong. Please try again.',
        snackBarType: SnackBarType.error,
      );
    } finally {
      CustomLoadingDialog.forceHide();
      isLoading.value = false;

    }
  }

  @override
  void onClose() {
    userEmail.dispose();
    super.onClose();
  }
}
