import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
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
  Future<String> create({
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

    return placeUniqueId!;
  }

  /// get other Reviews by Place / Merchant
  Future<List<ReviewPlaceModel>> otherReviewGetByPlace({
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
    LeLog.rd(this, otherReviewGetByPlace, data.toString());
    return data;
  }

  /// get my Reviews by Place / Merchant
  Future<ReviewPlaceModel> myReviewGetByPlace({
    required String placeId,
  }) async {
    // final reviewPlaceBox =
    //     Hive.box<ReviewPlaceModel>(MyHive.reviewPlaceModel.name);

    // if (reviewPlaceBox.values.toList().isNotEmpty) {
    //   final reviewPlaceList = reviewPlaceBox.values.toList();
    //   LeLog.rd(this, getByPlace, reviewPlaceList.toString());
    //   return reviewPlaceList;
    // }
    debugPrint('LeRucco');
    debugPrint(placeId); // ChIJb59oH_P1aS4RePRpX6xEoP0

    final res = await _dioClient.dio().then((dio) {
      return dio.get('/reviews/$placeId/place/me');
    });

    final data = ReviewPlaceModel.fromMap(res.data);
    LeLog.rd(this, myReviewGetByPlace, data.toString());
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

  /// Review Add Like
  Future<void> addLike({required int reviewId}) async {
    final _ = await _dioClient.dio().then((dio) {
      return dio.post('/reviews/$reviewId/like/add');
    });
    return;
  }

  /// Review Remove Like
  Future<void> removeLike({required int reviewId}) async {
    final _ = await _dioClient.dio().then((dio) {
      return dio.delete('/reviews/$reviewId/like/remove');
    });
    return;
  }
}
