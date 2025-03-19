import 'package:dio/dio.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/_data/error_handler.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/spa/model/spa_detail_model.dart';
import 'package:kualiva/places/spa/model/spa_nearest_model.dart';
import 'package:kualiva/places/spa/model/spa_promo_model.dart';

class SpaRepository {
  SpaRepository(this._dioClient);

  final DioClient _dioClient;

  Future<List<SpaNearestModel>> getPlacesNearest({
    required double latitude,
    required double longitude,
  }) async {
    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/places/nearest',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'type': PlaceCategoryEnum.spa.name,
        },
      );
    });
    final data = (res.data['data'] as List<dynamic>)
        .map((e) => SpaNearestModel.fromMap(e))
        .toList();

    LeLog.rd(this, getPlacesNearest, data.toString());
    return data;
  }

  Future<SpaDetailModel> getPlaceDetail({
    required String placeId,
  }) async {
    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/places/byPlaceId',
        queryParameters: {'placeUniqueId': placeId},
      );
    });
    final data = SpaDetailModel.fromMap(res.data['data']);
    LeLog.rd(this, getPlaceDetail, data.toString());
    return data;
  }

  Future<List<SpaPromoModel>> getPromos({
    required PlaceCategoryEnum placeCategoryEnum,
  }) async {
    try {
      final res = await _dioClient.dio().then((dio) {
        return dio.get(
          '/places/promo',
          queryParameters: {'type': placeCategoryEnum.name},
        );
      });

      final data = (res.data['data'] as List<dynamic>)
          .map((e) => SpaPromoModel.fromMap(e))
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
