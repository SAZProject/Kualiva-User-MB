import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/nightlife/model/nightlife_detail_model.dart';

class NightlifeRepository {
  NightlifeRepository(this._dioClient);

  final DioClient _dioClient;

  Future<NightlifeDetailModel> getPlaceDetail({
    required String placeId,
  }) async {
    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/place/byPlaceId',
        queryParameters: {'placeUniqueId': placeId},
      );
    });
    final data = NightlifeDetailModel.fromMap(res.data['data']);
    LeLog.rd(this, getPlaceDetail, data.toString());
    return data;
  }
}
