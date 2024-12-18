import 'package:kualiva/common/utility/check_device.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckPermission {
  static Future<bool> checkDevicePermission() async {
    if (CheckDevice.isAndroid()) {
      if (await Permission.location.isPermanentlyDenied ||
          await Permission.location.isDenied) {
        return false;
      }
      if (await Permission.camera.isPermanentlyDenied ||
          await Permission.camera.isDenied) {
        return false;
      }
      if (await Permission.microphone.isPermanentlyDenied ||
          await Permission.microphone.isDenied) {
        return false;
      }
      if (await CheckDevice.isAndroid13plus()) {
        if (await Permission.photos.isPermanentlyDenied ||
            await Permission.photos.isDenied) {
          return false;
        }
      } else {
        if (await Permission.storage.isPermanentlyDenied ||
            await Permission.storage.isDenied) {
          return false;
        }
      }
    }
    return true;
  }
}
