import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:like_it/common/utility/lelog.dart';

class CheckDevice {
  static bool isAndroid() {
    return Platform.isAndroid;
  }

  static Future<bool> isAndroid13plus() async {
    final DeviceInfoPlugin info = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await info.androidInfo;
    final int androidVersion = int.parse(androidInfo.version.release);
    LeLog.d(isAndroid13plus, "Android version : $androidVersion");
    if (androidVersion >= 13) return true;
    return false;
  }
}
