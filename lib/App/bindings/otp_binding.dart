import 'package:get/get.dart';
import 'package:orioconnect/presentation/controller/otp_controller.dart';
import '../../data/services/login_service.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<LoginService>()) {
      Get.lazyPut<LoginService>(() => LoginService(), fenix: true);
    }

    if (Get.isRegistered<OtpController>()) {
      Get.delete<OtpController>(force: true);
    }
    
    Get.lazyPut<OtpController>(
      () => OtpController(),
      fenix: false,
    );
  }
}