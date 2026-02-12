import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:orioconnect/App/routes/app_routes.dart';
import 'package:orioconnect/Utils/CircularProgressIndicator/circular_progress_indicator.dart';
import 'package:orioconnect/Utils/Snackbar/custom_snackbar.dart';
import 'package:orioconnect/core/storage/secure_storage_service.dart';
import 'package:orioconnect/data/services/login_service.dart';

class OtpController extends GetxController {
  final LoginService _loginService = Get.find();
  List<TextEditingController> otpControllers = [];
  List<FocusNode> focusNodes = [];
  final RxString errorMessage = ''.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
    Future.delayed(Duration(milliseconds: 500), () {
      if (focusNodes.isNotEmpty && focusNodes[0].canRequestFocus) {
        focusNodes[0].requestFocus();
      }
    });
  }

  void _initializeControllers() {
    _disposeControllers();

    otpControllers = List.generate(6, (index) => TextEditingController());
    focusNodes = List.generate(6, (index) => FocusNode());
  }

  void _disposeControllers() {
    for (var controller in otpControllers) {
      try {
        controller.dispose();
      } catch (e) {
        log("OTP Controller Dispose Error: $e");
      }
    }

    for (var focusNode in focusNodes) {
      try {
        focusNode.dispose();
      } catch (e) {
        log("OTP FocusNode Dispose Error: $e");
      }
    }
    otpControllers.clear();
    focusNodes.clear();
  }

  String getOtp() {
    return otpControllers.map((controller) => controller.text).join();
  }

  Future<void> verifyOtp() async {
    errorMessage.value = '';
    final otp = getOtp();
    if (otp.length != 6) {
      errorMessage.value = 'Please enter complete 6-digit OTP';
      customSnackBar(
        'Error',
        'Please enter complete 6-digit OTP',
        snackBarType: SnackBarType.error,
      );
      return;
    }

    final userId = await SecureStorageService.getUserId();
    log("User id :: $userId");
    if (userId == null || userId.isEmpty) {
      errorMessage.value = 'User ID not found. Please login again.';
      customSnackBar(
        'Error',
        'User ID not found. Please login again.',
        snackBarType: SnackBarType.error,
      );
      Get.offAllNamed(AppRoutes.loginRoute);
      return;
    }

    isLoading.value = true;
    CustomLoadingDialog.show();

    try {
      final response = await _loginService.verifyOtp(
        username: userId,
        otp: int.parse(otp),
      );
      CustomLoadingDialog.hide();
      isLoading.value = false;

      if (response.isSuccess) {
        if (response.userData != null) {
          final userData = response.userData!;
          await SecureStorageService.saveToken(userData.token);
          await SecureStorageService.saveUserId(userData.username);
          await SecureStorageService.saveUserEmail(userData.email);
          await SecureStorageService.saveUserType(userData.type);
          await SecureStorageService.saveEmployeeId(
            userData.employeeId.toString(),
          );

          if (userData.employee != null) {
            final employee = userData.employee!;
            await SecureStorageService.saveEmpNo(employee.employeeCode);
            await SecureStorageService.saveUserName(employee.fullName);

            if (employee.phone != null && employee.phone!.isNotEmpty) {
              await SecureStorageService.saveUserPhone(employee.phone!);
            }

            if (employee.profilePicture != null &&
                employee.profilePicture!.isNotEmpty) {
              await SecureStorageService.saveProfilePicture(
                employee.profilePicture!,
              );
            }

            if (employee.cnic != null && employee.cnic!.isNotEmpty) {
              await SecureStorageService.saveUserCnic(employee.cnic!);
            }

            if (employee.gender != null && employee.gender!.isNotEmpty) {
              await SecureStorageService.saveUserGender(employee.gender!);
            }

            if (employee.dob != null && employee.dob!.isNotEmpty) {
              await SecureStorageService.saveUserDob(employee.dob!);
            }

            if (employee.address != null && employee.address!.isNotEmpty) {
              await SecureStorageService.saveUserAddress(employee.address!);
            }
            if (employee.joinDate != null && employee.joinDate!.isNotEmpty) {
              await SecureStorageService.saveJoinDate(employee.joinDate!);
            }
            if (employee.departmentId != null) {
              await SecureStorageService.saveDepartmentId(
                employee.departmentId.toString(),
              );
            }
            if (employee.designationId != null) {
              await SecureStorageService.saveDesignationId(
                employee.designationId.toString(),
              );
            }
            await SecureStorageService.saveUserStatus(employee.status);
          }
          log("User data saved successfully");
        }

        customSnackBar(
          'Success',
          response.message,
          snackBarType: SnackBarType.success,
        );
        Get.offAllNamed(AppRoutes.homeRoute);
      } else {
        errorMessage.value = response.message;
        customSnackBar(
          'Error',
          response.message,
          snackBarType: SnackBarType.error,
        );
      }
    } catch (e) {
      log("OTP Verification Error: $e");
      CustomLoadingDialog.hide();
      isLoading.value = false;
    } finally {
      CustomLoadingDialog.forceHide();
      isLoading.value = false;
    }
  }

  void clearOtp() {
    for (var controller in otpControllers) {
      controller.clear();
    }
    if (focusNodes.isNotEmpty && focusNodes[0].canRequestFocus) {
      focusNodes[0].requestFocus();
    }
    errorMessage.value = '';
  }

  @override
  void onClose() {
    _disposeControllers();
    super.onClose();
  }
}
