import 'package:hive/hive.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/main_hive.dart';
import 'package:kualiva/places/nightlife/model/nightlife_nearest_model.dart';
import 'package:kualiva/places/nightlife/model/nightlife_nearest_page.dart';

class NightlifeNearestRepository {
  NightlifeNearestRepository(this._dioClient);

  final DioClient _dioClient;

  NightlifeNearestPage? getNearestOld() {
    final boxName = MyBox.nightlifeNearestPage.name;
    final nightlifeNearestBox = Hive.box<NightlifeNearestPage>(boxName);
    return nightlifeNearestBox.get(boxName);
  }

  Future<NightlifeNearestPage> getNearest({
    required Paging paging,
    required PagingEnum pagingEnum,
    required double latitude,
    required double longitude,
  }) async {
    final boxName = MyBox.nightlifeNearestPage.name;
    final nightlifeNearestBox = Hive.box<NightlifeNearestPage>(boxName);

    final oldPage = nightlifeNearestBox.get(boxName);

    if ((pagingEnum == PagingEnum.before || pagingEnum == PagingEnum.started) &&
        oldPage != null) {
      return oldPage;
    }

    final res = await _dioClient.dio().then((dio) {
      return dio.get(
        '/places/nearest',
        queryParameters: {
          ...paging.toMap(),
          'latitude': latitude,
          'longitude': longitude,
          'type': PlaceCategoryEnum.nightLife.name,
        },
      );
    });
    final page = NightlifeNearestPage(
      data: (res.data['data'] as List<dynamic>)
          .map((e) => NightlifeNearestModel.fromMap(e))
          .toList(),
      pagination: Pagination.fromMap(res.data['pagination']),
    );

    if (pagingEnum == PagingEnum.paged) {
      final List<NightlifeNearestModel> tempList = [
        ...(oldPage?.data ?? []),
        ...page.data
      ];
      page.data.clear();
      page.data.addAll(tempList);
    }

    await nightlifeNearestBox.delete(boxName);
    await nightlifeNearestBox.put(boxName, page);

    LeLog.rd(this, getNearest, page.toString());
    return page;
  }
}
