import 'package:hive_flutter/hive_flutter.dart';
import 'package:like_it/data/current_location/current_location_model.dart';

import 'package:like_it/places/fnb/model/fnb_nearest_model.dart';

class MainHive {
  static Future<void> registerAdapter() async {
    await Hive.initFlutter();
    Hive.registerAdapter(FnbNearestLocationAdapter());
    Hive.registerAdapter(FnbNearestModelAdapter());
    Hive.registerAdapter(CurrentLocationModelAdapter());
  }

  static Future<void> openBox() async {
    await Future.wait([
      Hive.openBox<FnbNearestModel>('fnb_nearest'),
    ]);
  }

  static bool checkOpenBox() {
    for (var e in MyHive.values) {
      if (!Hive.isAdapterRegistered(e.typeId)) {
        return false;
      }
    }
    return true;
  }
}

enum MyHive {
  fnbNearestLocation(0, ''),
  fnbNearestModel(1, 'fnb_nearest'),
  currentLocationModel(2, 'current_location');

  final int typeId;
  final String name;

  const MyHive(this.typeId, this.name);
}
