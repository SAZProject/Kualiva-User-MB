import 'package:like_it/common/utility/image_constant.dart';
import 'package:like_it/data/dio_client.dart';
import 'package:like_it/home/model/home_ad_banner_model.dart';

class PromotionRepository {
  PromotionRepository(this._dioClient);

  final DioClient _dioClient;

  final List<HomeAdBannerModel> _homeAdBannerDummy = [
    HomeAdBannerModel(
      urlImage: ImageConstant.event1,
    ),
    HomeAdBannerModel(
      urlImage: ImageConstant.event2,
      placeId: 'ChIJ5Ts2IiHyaS4R67B-PvQGtxY',
    ),
    HomeAdBannerModel(
      urlImage: ImageConstant.foodSugarSpice,
      urlWeb: 'https://www.youtube.com/@tanboykun',
    ),
    HomeAdBannerModel(
      urlImage: ImageConstant.foodTable8,
      placeId: "ChIJlUYNUs3xaS4RRs0Mrh_empk",
    ),
    HomeAdBannerModel(
      urlImage: ImageConstant.event3,
    ),
  ];

  Future<List<HomeAdBannerModel>> getAdvertisementBanner() async {
    /// TODO Wait for promotion service API

    // final res = await _dioClient.dio().then((dio) {
    //   return dio.get(
    //     '/program-promotion/banner',
    //     queryParameters: Map.from(
    //       {
    //         'level': 1,
    //         'date': DateTime.now(),
    //       },
    //     ),
    //   );
    // });
    // final _ = (res.data as List<dynamic>)
    //     .map((e) => HomeAdBannerModel.fromMap(e))
    //     .toList();

    return _homeAdBannerDummy;
  }
}
