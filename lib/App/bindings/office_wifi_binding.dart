import 'package:get/get.dart';
import 'package:orioconnect/data/services/office_wifi_serive.dart';
import 'package:orioconnect/presentation/controller/office_wifi_controller.dart';

class OfficeWifiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfficeWifiSerive>(() => OfficeWifiSerive(), fenix: true);
    Get.lazyPut<OfficeWifiController>(() => OfficeWifiController(), fenix: false);
  }
}
