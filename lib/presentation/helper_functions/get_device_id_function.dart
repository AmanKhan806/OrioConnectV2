import 'dart:developer';

import 'package:persistent_device_id/persistent_device_id.dart';

class GetDeviceIdFunction {
  Future<String> getPersistentDeviceId() async {
    try {
      final deviceId = await PersistentDeviceId.getDeviceId();
      log("Device id :: $deviceId");
      return deviceId ?? "";
    } catch (e) {
      return 'Error generating ID: $e';
    }
  }
}
