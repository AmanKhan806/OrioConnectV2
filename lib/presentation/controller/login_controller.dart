import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orioconnect/App/routes/app_routes.dart';
import 'package:orioconnect/Utils/CircularProgressIndicator/circular_progress_indicator.dart';
import 'package:orioconnect/Utils/Snackbar/custom_snackbar.dart';
import 'package:orioconnect/core/storage/secure_storage_service.dart';
import 'package:orioconnect/data/services/login_service.dart';

class LoginController extends GetxController {
  final LoginService _loginService = Get.find();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final RxBool _hidePassword = true.obs;

  RxBool get hidePassword => _hidePassword;

  void togglePasswordVisibility() {
    _hidePassword.value = !_hidePassword.value;
  }

  Future<void> loginWithEmail(GlobalKey<FormState> formKey) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (email.text.trim().isEmpty) {
      customSnackBar(
        'Error',
        'Please enter user name',
        snackBarType: SnackBarType.error,
      );
      return;
    }

    if (password.text.trim().isEmpty) {
      customSnackBar(
        'Error',
        'Please enter password',
        snackBarType: SnackBarType.error,
      );
      return;
    }

    CustomLoadingDialog.show();
    try {
      final response = await _loginService.login(
        userId: email.text.trim(),
        password: password.text.trim(),
      );
      CustomLoadingDialog.hide();
      if (response.isSuccess) {
          await SecureStorageService.saveUserId(email.text.trim());
        customSnackBar(
          'Success',
          response.message,
          snackBarType: SnackBarType.success,
        );
        Get.toNamed(AppRoutes.otpRoute);
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
      customSnackBar(
        'Error',
        'Something went wrong. Please try again.',
        snackBarType: SnackBarType.error,
      );
    } finally {
      CustomLoadingDialog.forceHide();
    }
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
