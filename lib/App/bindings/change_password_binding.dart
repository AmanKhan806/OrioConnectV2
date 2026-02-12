import 'package:get/get.dart';
import 'package:orioconnect/data/services/change_password_service.dart';
import 'package:orioconnect/presentation/controller/change_password_controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordService>(() => ChangePasswordService(), fenix: true);
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController(), fenix: false);
  }
}
