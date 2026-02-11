
import 'package:get/get.dart';
import 'package:orioconnect/App/routes/app_routes.dart';
import 'dart:developer';

import 'package:orioconnect/core/storage/secure_storage_service.dart';


class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    
    try {
      final isLoggedIn = await SecureStorageService.isLoggedIn();
      log("Is logged in: $isLoggedIn");

      if (isLoggedIn) {        
        Get.offAllNamed(AppRoutes.homeRoute);
      } else {
        Get.offAllNamed(AppRoutes.loginRoute);
      }
    } catch (e) {
      log("Error checking auth status: $e");
      Get.offAllNamed(AppRoutes.loginRoute);
    }
  }
}