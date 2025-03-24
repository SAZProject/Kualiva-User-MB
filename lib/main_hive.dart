// ignore_for_file: unused_field

import 'package:hive_flutter/hive_flutter.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/common/feature/current_location/current_location_placemark_model.dart';
import 'package:kualiva/_data/model/parameter/language_explain_model.dart';
import 'package:kualiva/_data/model/parameter/parameter_detail_model.dart';
import 'package:kualiva/_data/model/parameter/parameter_model.dart';
import 'package:kualiva/auth/model/user_model.dart';
import 'package:kualiva/auth/model/user_profile_model.dart';
import 'package:kualiva/common/feature/current_location/current_location_model.dart';

import 'package:kualiva/places/fnb/model/fnb_nearest_model.dart';
import 'package:kualiva/places/fnb/model/fnb_nearest_page.dart';
import 'package:kualiva/places/fnb/model/fnb_promo_model.dart';
import 'package:kualiva/places/fnb/model/fnb_promo_page.dart';
import 'package:kualiva/places/fnb/model/fnb_recommended_model.dart';
import 'package:kualiva/places/fnb/model/fnb_recommended_page.dart';
import 'package:kualiva/places/nightlife/model/nightlife_nearest_model.dart';
import 'package:kualiva/places/nightlife/model/nightlife_nearest_page.dart';
import 'package:kualiva/places/nightlife/model/nightlife_promo_model.dart';
import 'package:kualiva/places/nightlife/model/nightlife_promo_page.dart';
import 'package:kualiva/places/nightlife/model/nightlife_recommended_model.dart';
import 'package:kualiva/places/nightlife/model/nightlife_recommended_page.dart';
import 'package:kualiva/places/spa/model/spa_nearest_model.dart';
import 'package:kualiva/places/spa/model/spa_nearest_page.dart';
import 'package:kualiva/places/spa/model/spa_promo_model.dart';
import 'package:kualiva/places/spa/model/spa_promo_page.dart';
import 'package:kualiva/places/spa/model/spa_recommended_model.dart';
import 'package:kualiva/places/spa/model/spa_recommended_page.dart';
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
    Hive.registerAdapter(FnbNearestPageAdapter());
    Hive.registerAdapter(SpaNearestModelAdapter());
    Hive.registerAdapter(SpaNearestPageAdapter());
    Hive.registerAdapter(NightlifeNearestModelAdapter());
    Hive.registerAdapter(NightlifeNearestPageAdapter());
    Hive.registerAdapter(FnbPromoModelAdapter());
    Hive.registerAdapter(FnbPromoPageAdapter());
    Hive.registerAdapter(FnbRecommendedModelAdapter());
    Hive.registerAdapter(FnbRecommendedPageAdapter());
    Hive.registerAdapter(NightlifePromoModelAdapter());
    Hive.registerAdapter(NightlifePromoPageAdapter());
    Hive.registerAdapter(NightlifeRecommendedModelAdapter());
    Hive.registerAdapter(NightlifeRecommendedPageAdapter());
    Hive.registerAdapter(SpaPromoModelAdapter());
    Hive.registerAdapter(SpaPromoPageAdapter());
    Hive.registerAdapter(SpaRecommendedModelAdapter());
    Hive.registerAdapter(SpaRecommendedPageAdapter());
  }

  static Future<Box<T>> openLeSafeBox<T>(MyBox myBox) async {
    try {
      return await Hive.openBox<T>(myBox.name);
    } catch (e) {
      await Hive.deleteBoxFromDisk(myBox.name);
      return Hive.openBox<T>(myBox.name);
    }
  }

  static Future<Box<T>> deleteBoxAndOpenLeSafe<T>(MyBox myBox) async {
    final box = await openLeSafeBox<T>(myBox);
    await box.deleteFromDisk();
    return await openLeSafeBox(myBox);
  }

  static Future<void> openBox() async {
    await Future.wait([
      openLeSafeBox<UserModel>(MyBox.user),
      openLeSafeBox<CurrentLocationModel>(MyBox.currentLocation),
      openLeSafeBox<ParameterModel>(MyBox.parameter),
      openLeSafeBox<ReviewFilterModel>(MyBox.reviewFilter),
      openLeSafeBox<List<String>>(MyBox.recentSuggestion),
      openLeSafeBox<ReviewPlacePage>(MyBox.reviewPlacePage),

      /// Spa
      openLeSafeBox<SpaNearestPage>(MyBox.spaNearestPage),
      openLeSafeBox<SpaPromoPage>(MyBox.spaPromoPage),
      openLeSafeBox<SpaRecommendedPage>(MyBox.spaRecommendedPage),

      /// Fnb
      openLeSafeBox<FnbNearestPage>(MyBox.fnbNearestPage),
      openLeSafeBox<FnbPromoPage>(MyBox.fnbPromoPage),
      openLeSafeBox<FnbRecommendedPage>(MyBox.fnbRecommendedPage),

      /// Nightlife
      openLeSafeBox<NightlifeNearestPage>(MyBox.nightlifeNearestPage),
      openLeSafeBox<NightlifePromoPage>(MyBox.nightlifePromoPage),
      openLeSafeBox<NightlifeRecommendedPage>(MyBox.nightlifeRecommendedPage),
    ]);
  }

  static Future<void> deleteAllBox() async {
    await Hive.close();
    await Hive.deleteFromDisk();
    await openBox();
  }

  static Future<void> deleteSplashBox() async {
    Future.wait([
      deleteBoxAndOpenLeSafe<CurrentLocationModel>(MyBox.currentLocation),
    ]);
  }

  static bool checkOpenBox() {
    // for (var e in MyBox.values) {
    //   if (!Hive.isAdapterRegistered(e.typeId)) {
    //     return false;
    //   }
    // }
    return true;
  }
}

enum MyBox {
  user('user'),
  currentLocation('my_current_location'),
  parameter('parameter'),
  reviewFilter('review_filter'),
  recentSuggestion('recent_suggestion'),
  reviewPlacePage('review_place_page'),

  /// Spa
  spaNearestPage('spa_nearest_page'),
  spaPromoPage('spa_promo_page'),
  spaRecommendedPage('spa_recommended_page'),

  /// Fnb
  fnbNearestPage('fnb_nearest_page'),
  fnbPromoPage('fnb_promo_page'),
  fnbRecommendedPage('fnb_recommended_page'),

  /// Night Life
  nightlifeNearestPage('nightlife_nearest_page'),
  nightlifePromoPage('nightlife_promo_page'),
  nightlifeRecommendedPage('nightlife_recommended_page');

  final String name;

  const MyBox(this.name);
}

enum _MyHive {
  fnbNearest(1),
  currentLocation(2),
  author(3),
  reviewPlace(4),
  userProfile(5),
  user(6),
  currentLocationPlacemark(7),
  languageExplain(8),
  parameterDetail(9),
  parameter(10),
  selectedUser(11),
  reviewOrder(12),
  reviewFilter(13),
  suggestion(14),
  pagination(15),
  reviewPlacePage(16),
  fnbNearestPage(17),
  spaNearest(18),
  spaNearestPage(19),
  nightlifeNearest(20),
  nightlifeNearestPage(21),
  fnbPromo(22),
  fnbPromoPage(23),
  fnbRecommended(24),
  fnbRecommendedPage(25),
  nightlifePromo(26),
  nightlifePromoPage(27),
  nightlifeRecommended(28),
  nightlifeRecommendedPage(29),
  spaPromo(30),
  spaPromoPage(31),
  spaRecommended(32),
  spaRecommendedPage(33),
  ;

  final int typeId;

  const _MyHive(this.typeId);
}
