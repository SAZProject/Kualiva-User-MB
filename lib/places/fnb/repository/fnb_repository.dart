import 'package:like_it/common/utility/lelog.dart';
import 'package:like_it/data/dio_client.dart';
import 'package:like_it/places/fnb/model/fnb_nearest_model.dart';

class FnbRepository {
  FnbRepository(this._dioClient);

  final DioClient _dioClient;

  List<FnbNearestModel> _fnbNearest = [];

  void invalidate() {
    _fnbNearest = [];
  }

  Future<List<FnbNearestModel>> getMerchantNearest({
    required double latitude,
    required double longitude,
  }) async {
    if (_fnbNearest.isNotEmpty) return _fnbNearest;

    // return [];

    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/merchant/nearby',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
        },
      );
    });

    final data = (res.data as List<dynamic>)
        .map((e) => FnbNearestModel.fromMap(e))
        .toList();

    LeLog.sd(this, getMerchantNearest, data.toString());
    return data;
  }
}
