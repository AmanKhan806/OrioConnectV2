import 'dart:developer';
import 'package:get/get.dart';
import 'package:orioconnect/App/routes/app_routes.dart';
import 'package:orioconnect/Utils/CircularProgressIndicator/circular_progress_indicator.dart';
import 'package:orioconnect/Utils/Snackbar/custom_snackbar.dart';
import 'package:orioconnect/core/storage/secure_storage_service.dart';
import 'package:orioconnect/data/services/logout_service.dart';

class LogoutController extends GetxController {
  final LogoutService logoutService = Get.find();
  final RxBool isLoading = false.obs;
  String userId = '';

  @override
  void onInit() {
    _loadUserId();
    super.onInit();
  }

  Future<void> _loadUserId() async {
    userId = await SecureStorageService.getUserId() ?? '';
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      CustomLoadingDialog.show();

      final response = await logoutService.logoutApi(userid: userId);

      if (response.isSuccess) {
        await SecureStorageService.clearAll();

        CustomLoadingDialog.hide();
        isLoading.value = false;

        customSnackBar(
          'Success',
          response.message,
          snackBarType: SnackBarType.success,
        );

        Get.offAllNamed(AppRoutes.loginRoute);
      } else {
        CustomLoadingDialog.hide();
        isLoading.value = false;

        customSnackBar(
          'Error',
          response.message,
          snackBarType: SnackBarType.error,
        );
      }
    } catch (e) {
      log("Logout error:: $e");
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
}
