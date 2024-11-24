import 'package:hive/hive.dart';
import 'package:like_it/common/utility/lelog.dart';
import 'package:like_it/data/dio_client.dart';
import 'package:like_it/main_hive.dart';
import 'package:like_it/places/fnb/model/fnb_detail_model.dart';
import 'package:like_it/places/fnb/model/fnb_nearest_model.dart';

class FnbRepository {
  FnbRepository(this._dioClient) {
    _fnbNearestBoxFuture = Hive.openBox<FnbNearestModel>('fnb_nearest');
  }

  final DioClient _dioClient;
  late Future<Box<FnbNearestModel>> _fnbNearestBoxFuture;

  void invalidate() {}

  Future<List<FnbNearestModel>> getMerchantNearest({
    required double latitude,
    required double longitude,
  }) async {
    // final fnbNearestBox = await _fnbNearestBoxFuture;
    final fnbNearestBox = Hive.box<FnbNearestModel>('fnb_nearest');

    /// TODO Check Internet Connection
    if (fnbNearestBox.values.toList().isNotEmpty) {
      LeLog.sd(
          this, getMerchantNearest, '_fnbNearestBox.values NOT EMPTY AAAAA');
      print("_fnbNearestBox.values NOT EMPTY");
      return fnbNearestBox.values.toList();
    }

    print("_fnbNearestBox.values KOSONG");

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
    final data = (res.data as List<dynamic>).map((e) {
      final temp = FnbNearestModel.fromMap(e);
      final key = fnbNearestBox.add(temp);
      print('key ${key}');
      return temp;
    }).toList();
    fnbNearestBox.addAll(data);
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
