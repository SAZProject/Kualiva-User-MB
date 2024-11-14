import 'package:like_it/common/utility/lelog.dart';
import 'package:like_it/data/dio_client.dart';
import 'package:like_it/places/fnb/model/fnb_detail_model.dart';
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

    final res = await _dioClient.dio().then((dio) {
      dio.options.baseUrl = 'https://kg1k4xc5-3001.asse.devtunnels.ms/api/v1';
      return dio.get(
        '/places/nearby',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
        },
      );
    });
    LeLog.sd(this, getMerchantNearest, res.data.toString());
    final data = (res.data as List<dynamic>)
        .map((e) => FnbNearestModel.fromMap(e))
        .toList();
    return data;
  }

  Future<FnbDetailModel> getMerchantDetail({
    required String placeId,
  }) async {
    final res = await _dioClient.dio().then((dio) {
      dio.options.baseUrl = 'https://kg1k4xc5-3001.asse.devtunnels.ms/api/v1';
      return dio.get(
        '/places/byPlaceId',
        queryParameters: {'placeId': placeId},
      );
    });
    LeLog.sd(this, getMerchantDetail, res.data.toString());
    final data = FnbDetailModel.fromMap(res.data);
    LeLog.sd(this, getMerchantDetail, data.toString());
    return data;
  }
}
