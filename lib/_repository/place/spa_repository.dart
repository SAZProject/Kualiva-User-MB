import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/places/spa/model/spa_detail_model.dart';

class SpaRepository {
  SpaRepository(this._dioClient);

  final DioClient _dioClient;

  Future<SpaDetailModel> getPlaceDetail({
    required String placeId,
  }) async {
    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/place/byPlaceId',
        queryParameters: {'placeUniqueId': placeId},
      );
    });
    final data = SpaDetailModel.fromMap(res.data['data']);
    LeLog.rd(this, getPlaceDetail, data.toString());
    return data;
  }
}
