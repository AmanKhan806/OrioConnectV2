import 'package:get/get.dart';
import 'package:orioconnect/data/services/forgot_password_service.dart';
import 'package:orioconnect/presentation/controller/forgot_password_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordService>(() => ForgotPasswordService(), fenix: true);
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController(), fenix: false);
  }
}
