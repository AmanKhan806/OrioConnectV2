import 'package:get/get.dart';
import 'package:orioconnect/data/services/login_service.dart';
import 'package:orioconnect/presentation/controller/login_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginService>(() => LoginService(), fenix: true);
    Get.lazyPut<LoginController>(() => LoginController(), fenix: false);
  }
}
