import 'package:hive_flutter/hive_flutter.dart';
import 'package:kualiva/data/current_location/current_location_model.dart';

import 'package:kualiva/places/fnb/model/fnb_nearest_model.dart';
import 'package:kualiva/review/model/author_model.dart';
import 'package:kualiva/review/model/review_place_model.dart';

class MainHive {
  static Future<void> registerAdapter() async {
    await Hive.initFlutter();
    Hive.registerAdapter(FnbNearestLocationAdapter());
    Hive.registerAdapter(FnbNearestModelAdapter());
    Hive.registerAdapter(CurrentLocationModelAdapter());
    Hive.registerAdapter(AuthorModelAdapter());
    Hive.registerAdapter(ReviewPlaceModelAdapter());
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
  currentLocationModel(2, 'current_location'),
  author(3, 'author'),
  reviewPlaceModel(4, 'review_place');

  final int typeId;
  final String name;

  const MyHive(this.typeId, this.name);
}
