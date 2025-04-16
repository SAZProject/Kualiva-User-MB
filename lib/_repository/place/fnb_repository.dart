import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/places/fnb/model/fnb_detail_model.dart';

class FnbRepository {
  FnbRepository(this._dioClient);

  final DioClient _dioClient;

  Future<FnbDetailModel> getPlaceDetail({
    required String placeId,
  }) async {
    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/place/byPlaceId',
        queryParameters: {'placeUniqueId': placeId},
      );
    });
    final data = FnbDetailModel.fromMap(res.data['data']);
    LeLog.rd(this, getPlaceDetail, data.toString());
    return data;
  }
}
