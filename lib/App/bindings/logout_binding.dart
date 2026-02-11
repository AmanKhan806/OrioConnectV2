import 'package:get/get.dart';
import 'package:orioconnect/data/services/logout_service.dart';
import 'package:orioconnect/presentation/controller/logout_controller.dart';

class LogoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogoutService>(() => LogoutService(), fenix: true);
    Get.lazyPut<LogoutController>(() => LogoutController(), fenix: false);
  }
}
