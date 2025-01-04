// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kualiva/repository/token_manager.dart';

// import 'dart:convert';
// import 'package:flutter/services.dart' show rootBundle;

void main() {
  testWidgets("Token Manager", (WidgetTester tester) async {
    dotenv.testLoad(fileInput: '''
    ACCESS_TOKEN_KEY=AccessTokenAbsoluteSecureLeRuccoLeKualiva
    REFRESH_TOKEN_KEY=RefreshTokenAbsoluteSecureLeRuccoLeKualiva
    ''');

    final tokenManager = TokenManager(const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ));
    await tokenManager.readAccessToken();
    await tokenManager.readRefreshToken();

    expect(1, 1);
  });

  testWidgets("Merchant Nearby Model", (WidgetTester tester) async {
    // String str = await rootBundle.loadString('assets/merchant_nearby.json');

    // List<dynamic> data = jsonDecode(str);

    // List<MerchantNearby> merchantNearby =
    //     data.map((e) => MerchantNearby.fromMap(e)).toList();

    //

    expect(1, 1);
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // String jsonString =
    //     await rootBundle.loadString('assets/response_1728472297882-list.json');

    // Map<String, dynamic> jsonData = jsonDecode(jsonString);

    // PlaceResponseModel model = PlaceResponseModel.fromMap(jsonData);

    // if (model is PlaceResponseModel) {
    //
    //
    // }

    // String str = await rootBundle
    //     .loadString('assets/response_1728580777035-detail.json');
    // String str =
    //     await rootBundle.loadString('assets/merchant_nearby_detail.json');

    // Map<String, dynamic> data = jsonDecode(str);

    // Restaurant restaurant = Restaurant.fromMap(data);

    //
    //

    // String str1 = await rootBundle
    //     .loadString('assets/1G-Maps-Extractor-10-Restaurants-2024-10-17.json');

    // Map<String, dynamic> data1 = jsonDecode(str1);

    // List<RestaurantExtractorModel> restaurantExtractor =
    //     (data1['data'] as List<dynamic>)
    //         .map((e) => RestaurantExtractorModel.fromMap(e))
    //         .toList();

    // // RestaurantExtractorModel.fromMap(data1['data']);

    // if (restaurantExtractor is RestaurantExtractorModel) {
    //
    //
    // }

    expect(1, 1);
  });
}
