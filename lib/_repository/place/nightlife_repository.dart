import 'package:dio/dio.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/_data/error_handler.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/nightlife/model/nightlife_detail_model.dart';
import 'package:kualiva/places/nightlife/model/nightlife_nearest_model.dart';
import 'package:kualiva/places/nightlife/model/nightlife_promo_model.dart';

class NightlifeRepository {
  NightlifeRepository(this._dioClient);

  final DioClient _dioClient;

  Future<List<NightlifeNearestModel>> getPlacesNearest({
    required double latitude,
    required double longitude,
  }) async {
    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/places/nearest',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'type': PlaceCategoryEnum.nightLife.name,
        },
      );
    });
    final data = (res.data as List<dynamic>)
        .map((e) => NightlifeNearestModel.fromMap(e))
        .toList();

    LeLog.rd(this, getPlacesNearest, data.toString());
    return data;
  }

  Future<NightlifeDetailModel> getPlaceDetail({
    required String placeId,
  }) async {
    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/places/byPlaceId',
        queryParameters: {'placeUniqueId': placeId},
      );
    });
    final data = NightlifeDetailModel.fromMap(res.data);
    LeLog.rd(this, getPlaceDetail, data.toString());
    return data;
  }

  Future<List<NightlifePromoModel>> getPromos({
    required PlaceCategoryEnum placeCategoryEnum,
  }) async {
    try {
      final res = await _dioClient.dio().then((dio) {
        return dio.get(
          '/places/promo',
          queryParameters: {'type': placeCategoryEnum.name},
        );
      });

      final data = (res.data as List<dynamic>)
          .map((e) => NightlifePromoModel.fromMap(e))
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
