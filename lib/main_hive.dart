import 'package:hive_flutter/hive_flutter.dart';
import 'package:kualiva/_data/feature/current_location/current_location_placemark_model.dart';
import 'package:kualiva/_data/model/pagination/my_page.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/parameter/language_explain_model.dart';
import 'package:kualiva/_data/model/parameter/parameter_detail_model.dart';
import 'package:kualiva/_data/model/parameter/parameter_model.dart';
import 'package:kualiva/auth/model/user_model.dart';
import 'package:kualiva/auth/model/user_profile_model.dart';
import 'package:kualiva/_data/feature/current_location/current_location_model.dart';

import 'package:kualiva/places/fnb/model/fnb_nearest_model.dart';
import 'package:kualiva/review/enum/review_order_enum.dart';
import 'package:kualiva/review/enum/review_selected_user_enum.dart';
import 'package:kualiva/review/model/author_model.dart';
import 'package:kualiva/review/model/review_filter_model.dart';
import 'package:kualiva/review/model/review_place_model.dart';
import 'package:kualiva/review/model/review_place_page.dart';

class MainHive {
  static Future<void> registerAdapter() async {
    await Hive.initFlutter();
    Hive.registerAdapter(FnbNearestModelAdapter());
    Hive.registerAdapter(CurrentLocationModelAdapter());
    Hive.registerAdapter(AuthorModelAdapter());
    Hive.registerAdapter(ReviewPlaceModelAdapter());
    Hive.registerAdapter(UserProfileModelAdapter());
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(CurrentLocationPlacemarkModelAdapter());
    Hive.registerAdapter(LanguageExplainModelAdapter());
    Hive.registerAdapter(ParameterDetailModelAdapter());
    Hive.registerAdapter(ParameterModelAdapter());
    Hive.registerAdapter(ReviewSelectedUserEnumAdapter());
    Hive.registerAdapter(ReviewOrderEnumAdapter());
    Hive.registerAdapter(ReviewFilterModelAdapter());
    Hive.registerAdapter(PaginationAdapter());
    Hive.registerAdapter(ReviewPlacePageAdapter());
  }

  static Future<void> openBox() async {
    await Future.wait([
      Hive.openBox<FnbNearestModel>(MyHive.fnbNearest.name),
      Hive.openBox<UserModel>(MyHive.user.name),
      Hive.openBox<CurrentLocationModel>(MyHive.currentLocation.name),
      Hive.openBox<ParameterModel>(MyHive.parameter.name),
      Hive.openBox<ReviewFilterModel>(MyHive.reviewFilter.name),
      Hive.openBox<List<String>>(MyHive.suggestion.name),
      Hive.openBox<ReviewPlacePage>(MyHive.reviewPlace.name),
    ]);
  }

  static Future<void> deleteAllBox() async {
    await Hive.close();
    await Hive.deleteFromDisk();
    await openBox();
  }

  static Future<void> deleteSplashBox() async {
    await Hive.box<CurrentLocationModel>(MyHive.currentLocation.name)
        .deleteFromDisk();
    await Hive.openBox<CurrentLocationModel>(MyHive.currentLocation.name);
  }

  static bool checkOpenBox() {
    // for (var e in MyHive.values) {
    //   if (!Hive.isAdapterRegistered(e.typeId)) {
    //     return false;
    //   }
    // }
    return true;
  }
}

enum MyHive {
  fnbNearest(1, 'fnb_nearest'),
  currentLocation(2, 'current_location'),
  author(3, 'author'),
  reviewPlace(4, 'review_place'),
  userProfile(5, 'profile'),
  user(6, 'user'),
  currentLocationPlacemark(7, 'current_location_placemark'),
  languageExplain(8, 'language_explain'),
  parameterDetail(9, 'parameter_detail'),
  parameter(10, 'parameter'),
  selectedUser(11, 'selected_user'),
  reviewOrder(12, 'review_order'),
  reviewFilter(13, 'review_filter'),
  suggestion(14, 'suggestion'),
  pagination(15, 'pagination'),
  reviewPlacePage(16, 'review_place_page');

  final int typeId;
  final String name;

  const MyHive(this.typeId, this.name);
}
