import 'package:dio/dio.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/_data/error_handler.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/places/fnb/model/fnb_detail_model.dart';
import 'package:kualiva/places/fnb/model/fnb_promo_model.dart';

class FnbRepository {
  FnbRepository(this._dioClient);

  final DioClient _dioClient;

  Future<FnbDetailModel> getPlaceDetail({
    required String placeId,
  }) async {
    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/places/byPlaceId',
        queryParameters: {'placeUniqueId': placeId},
      );
    });
    final data = FnbDetailModel.fromMap(res.data['data']);
    LeLog.rd(this, getPlaceDetail, data.toString());
    return data;
  }

  Future<List<FnbPromoModel>> getPromos({
    required PlaceCategoryEnum placeCategoryEnum,
  }) async {
    try {
      final res = await _dioClient.dio().then((dio) {
        return dio.get(
          '/places/promo',
          queryParameters: {
            'type': placeCategoryEnum.name,
          },
        );
      });
      final data = (res.data['data'] as List<dynamic>)
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
