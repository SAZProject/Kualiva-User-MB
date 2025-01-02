import 'package:dio/dio.dart';
// import 'package:hive/hive.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/data/dio_client.dart';
import 'package:kualiva/data/place_category_enum.dart';
// import 'package:kualiva/main_hive.dart';
import 'package:kualiva/review/model/review_place_model.dart';

// AuthorId
// cm3d0h52q0000qtfl1aoq65b8

class ReviewRepository {
  ReviewRepository(this._dioClient);

  final DioClient _dioClient;

  String? placeUniqueId;
  PlaceCategoryEnum? placeCategory;
  String? invoice;
  String? invoiceFile;

  void tempCreate(
    String placeUniqueId,
    PlaceCategoryEnum placeCategory,
    String invoice,
    String invoiceFile,
  ) {
    this.placeUniqueId = placeUniqueId;
    this.placeCategory = placeCategory;
    this.invoice = invoice;
    this.invoiceFile = invoiceFile;
    LeLog.rd(this, tempCreate,
        "$placeUniqueId | $placeCategory | $invoice | $invoiceFile");
  }

  /// Add Reviews by Place
  Future<void> create({
    required String description,
    required double rating,
    required List<String> photoFiles,
  }) async {
    final _ = await _dioClient.dio().then((dio) {
      return dio.post(
        '/reviews',
        data: {
          "placeUniqueId": placeUniqueId,
          "placeCategory": placeCategory!.name,
          "invoice": invoice,
          "description": description,
          "invoiceFile": invoiceFile,
          "rating": rating,
          "photoFiles": photoFiles,
        },
      );
    });

    // final data = (res.data as List<dynamic>)
    //     .map((e) => ReviewPlaceModel.fromMap(e))
    //     .toList();

    return;
  }

  /// Reviews by Place / Merchant
  Future<List<ReviewPlaceModel>> getByPlace({
    required String placeId,
  }) async {
    // final reviewPlaceBox =
    //     Hive.box<ReviewPlaceModel>(MyHive.reviewPlaceModel.name);

    // if (reviewPlaceBox.values.toList().isNotEmpty) {
    //   final reviewPlaceList = reviewPlaceBox.values.toList();
    //   LeLog.rd(this, getByPlace, reviewPlaceList.toString());
    //   return reviewPlaceList;
    // }

    final res = await _dioClient.dio().then((dio) {
      return dio.get('/reviews/$placeId/place');
    });

    final data = (res.data as List<dynamic>)
        .map((e) => ReviewPlaceModel.fromMap(e))
        .toList();
    // reviewPlaceBox.addAll(data);
    LeLog.rd(this, getByPlace, data.toString());
    return data;
  }

  /// Review Place Search Text
  Future<void> getBySearchText({required String text}) async {
    final _ = await _dioClient.dio().then((dio) {
      return dio.get(
        '/',
        queryParameters: Map.from(
          {'text': text},
        ),
      );
    });
    return;
  }
}
/// 3000 auth
/// 3001 places
/// 3002 review
/// abc1230 