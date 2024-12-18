import 'package:hive/hive.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/data/dio_client.dart';
import 'package:kualiva/places/fnb/model/fnb_detail_model.dart';
import 'package:kualiva/places/fnb/model/fnb_nearest_model.dart';

class FnbRepository {
  FnbRepository(this._dioClient);

  final DioClient _dioClient;

  void invalidate() {}

  Future<List<FnbNearestModel>> getMerchantNearest({
    required double latitude,
    required double longitude,
  }) async {
    final fnbNearestBox = Hive.box<FnbNearestModel>('fnb_nearest');

    if (fnbNearestBox.values.toList().isNotEmpty) {
      final fnbNearestList = fnbNearestBox.values.toList();
      LeLog.rd(this, getMerchantNearest, fnbNearestList.toString());
      return fnbNearestList;
    }

    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/places/nearby',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
        },
      );
    });
    final data = (res.data as List<dynamic>)
        .map((e) => FnbNearestModel.fromMap(e))
        .toList();
    fnbNearestBox.addAll(data);
    LeLog.rd(this, getMerchantNearest, data.toString());
    return data;
  }

  Future<FnbDetailModel> getMerchantDetail({
    required String placeId,
  }) async {
    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/places/byPlaceId',
        queryParameters: {'placeId': placeId},
      );
    });
    final data = FnbDetailModel.fromMap(res.data);
    LeLog.rd(this, getMerchantDetail, data.toString());
    return data;
  }
}
