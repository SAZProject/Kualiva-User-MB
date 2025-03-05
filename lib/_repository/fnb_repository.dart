import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/_data/error_handler.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/main_hive.dart';
import 'package:kualiva/places/fnb/model/fnb_detail_model.dart';
import 'package:kualiva/places/fnb/model/fnb_nearest_model.dart';
import 'package:kualiva/places/fnb/model/fnb_promo_model.dart';

class FnbRepository {
  FnbRepository(this._dioClient);

  final DioClient _dioClient;

  void invalidate() {}

  Future<List<FnbNearestModel>> getPlacesNearest({
    required bool isRefreshed,
    required double latitude,
    required double longitude,
  }) async {
    final fnbNearestBox = Hive.box<FnbNearestModel>(MyHive.fnbNearest.name);

    if (!isRefreshed && fnbNearestBox.values.toList().isNotEmpty) {
      final fnbNearestList = fnbNearestBox.values.toList();
      LeLog.rd(this, getPlacesNearest, fnbNearestList.toString());
      return fnbNearestList;
    }

    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/places/nearest',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'type': PlaceCategoryEnum.fnb.name,
        },
      );
    });
    final data = (res.data as List<dynamic>)
        .map((e) => FnbNearestModel.fromMap(e))
        .toList();
    fnbNearestBox.addAll(data);
    LeLog.rd(this, getPlacesNearest, data.toString());
    return data;
  }

  Future<List<FnbNearestModel>> getPlacesNearestHotel({
    required double latitude,
    required double longitude,
  }) async {
    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/places/nearest-hotel',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'type': 'ALL',
        },
      );
    });
    final data = (res.data as List<dynamic>)
        .map((e) => FnbNearestModel.fromMap(e))
        .toList();
    LeLog.rd(this, getPlacesNearest, data.toString());
    return data;
  }

  Future<FnbDetailModel> getPlaceDetail({
    required String placeId,
  }) async {
    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/places/byPlaceId',
        queryParameters: {'placeUniqueId': placeId},
      );
    });
    final data = FnbDetailModel.fromMap(res.data);
    LeLog.rd(this, getPlaceDetail, data.toString());
    return data;
  }

  Future<List<FnbPromoModel>> getPromos({
    required PlaceCategoryEnum placeCategoryEnum,
  }) async {
    try {
      final res = await _dioClient.dio().then((dio) {
        return dio.get('/places/promo',
            queryParameters: {'type': placeCategoryEnum.name});
      });
      final data = (res.data as List<dynamic>)
          .map((e) => FnbPromoModel.fromMap(e))
          .toList();
      LeLog.rd(this, getPromos, data.toString());
      return data;
    } on DioException catch (e) {
      final failure = ErrorHandler.handle(e).failure;
      LeLog.re(this, getPromos, failure.toString());
      throw failure;
    }
  }
}
