import 'package:hive/hive.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/main_hive.dart';
import 'package:kualiva/places/nightlife/model/nightlife_recommended_model.dart';
import 'package:kualiva/places/nightlife/model/nightlife_recommended_page.dart';

class NightlifeRecommendedRepository {
  NightlifeRecommendedRepository(this._dioClient);

  final DioClient _dioClient;

  NightlifeRecommendedPage? getRecommendedOld(String? name) {
    String boxName = MyBox.nightlifeRecommendedPage.name;
    if (name != null) boxName = MyBox.nightlifeRecommendedPage.name;

    final nightlifeRecommendedBox = Hive.box<NightlifeRecommendedPage>(boxName);
    return nightlifeRecommendedBox.get(boxName);
  }

  Future<NightlifeRecommendedPage> getRecommended({
    required Paging paging,
    required PagingEnum pagingEnum,
    required double latitude,
    required double longitude,
    String? name,
  }) async {
    String boxName = MyBox.nightlifeRecommendedPage.name;
    if (name != null) boxName = MyBox.nightlifeRecommendedPage.name;

    final nightlifeRecommendedBox = Hive.box<NightlifeRecommendedPage>(boxName);

    final oldPage = nightlifeRecommendedBox.get(boxName);

    if ((pagingEnum == PagingEnum.before || pagingEnum == PagingEnum.started) &&
        oldPage != null) {
      return oldPage;
    }

    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/place/recommended',
        queryParameters: {
          ...paging.toMap(),
          'latitude': latitude,
          'longitude': longitude,
          'type': PlaceCategoryEnum.nightLife.name,
          'name': name
        },
      );
    });
    final page = NightlifeRecommendedPage(
      data: (res.data['data'] as List<dynamic>)
          .map((e) => NightlifeRecommendedModel.fromMap(e))
          .toList(),
      pagination: Pagination.fromMap(res.data['pagination']),
    );

    if (pagingEnum == PagingEnum.paged) {
      final List<NightlifeRecommendedModel> tempList = [
        ...(oldPage?.data ?? []),
        ...page.data
      ];
      page.data.clear();
      page.data.addAll(tempList);
    }

    await nightlifeRecommendedBox.delete(boxName);
    await nightlifeRecommendedBox.put(boxName, page);

    LeLog.rd(this, getRecommended, page.toString());
    return page;
  }
}
