import 'package:kualiva/common/dataset/f_n_b_dataset.dart';
import 'package:kualiva/common/utility/image_constant.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/data/dio_client.dart';
import 'package:kualiva/home/model/home_ad_banner_model.dart';
import 'package:kualiva/home/model/home_featured_model.dart';

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

  final List<HomeFeaturedModel> _homeFeaturedDummy =
      FNBDataset().featuredItemsDataset.map((e) {
    return HomeFeaturedModel(
      id: e.id,
      location: HomeFeaturedLocation(
        type: 'Point',
        coordinates: [106.80867612698492, -6.213683336779805],
      ),
      name: e.placeName,
      fullAddress: e.placeAddress,
      street: e.placeAddress,
      municipality: '',
      categories: e.tags,
      timezone: '',
      phone: e.phoneNumber,
      phones: [],
      claimed: 'false',
      reviewCount: e.totalReview,
      averageRating: e.avgRating,
      reviewUrl: '',
      googleMapsUrl: '',
      latitude: 1.2,
      longitude: 1.2,
      website: '',
      openingHours: '',
      featuredImage: e.placePicture[0],
      cid: '',
      fid: '',
      placeId: e.id,
    );
  }).toList();

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

    final data = _homeAdBannerDummy;

    LeLog.rd(this, getAdvertisementBanner, data.toString());

    return data;
  }

  Future<List<HomeFeaturedModel>> getFeatured(
      // {
      //   required double latitude,
      //   required double longitude,
      // }
      ) async {
    // final res = await _dioClient.dio().then((dio) {
    //   return dio.get(
    //     '/program-promotion/featured',
    //     queryParameters: Map.from({
    //       'latitude': latitude,
    //       'longitude': longitude,
    //     }),
    //   );
    // });

    // final _ = (res.data as List<dynamic>)
    //     .map((e) => HomeFeaturedModel.fromMap(e))
    //     .toList();

    final data = _homeFeaturedDummy;

    LeLog.rd(this, getFeatured, data.toString());

    return _homeFeaturedDummy;
  }
}
