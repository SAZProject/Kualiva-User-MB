import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/nightlife/model/nightlife_detail_model.dart';
import 'package:kualiva/places/nightlife/model/nightlife_nearest_model.dart';

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
          'type': 'ALL',
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
}
