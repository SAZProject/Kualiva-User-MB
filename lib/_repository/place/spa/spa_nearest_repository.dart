import 'package:hive/hive.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/main_hive.dart';
import 'package:kualiva/places/spa/model/spa_nearest_model.dart';
import 'package:kualiva/places/spa/model/spa_nearest_page.dart';

class SpaNearestRepository {
  SpaNearestRepository(this._dioClient);

  final DioClient _dioClient;

  SpaNearestPage? getNearestOld() {
    final boxName = MyBox.spaNearestPage.name;
    final spaNearestBox = Hive.box<SpaNearestPage>(boxName);
    return spaNearestBox.get(boxName);
  }

  Future<SpaNearestPage> getNearest({
    required Paging paging,
    required PagingEnum pagingEnum,
    required double latitude,
    required double longitude,
  }) async {
    final boxName = MyBox.spaNearestPage.name;
    final spaNearestBox = Hive.box<SpaNearestPage>(boxName);

    final oldPage = spaNearestBox.get(boxName);

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
          'type': PlaceCategoryEnum.spa.name,
        },
      );
    });
    final page = SpaNearestPage(
      data: (res.data['data'] as List<dynamic>)
          .map((e) => SpaNearestModel.fromMap(e))
          .toList(),
      pagination: Pagination.fromMap(res.data['pagination']),
    );

    if (pagingEnum == PagingEnum.paged) {
      final List<SpaNearestModel> tempList = [
        ...(oldPage?.data ?? []),
        ...page.data
      ];
      page.data.clear();
      page.data.addAll(tempList);
    }

    await spaNearestBox.delete(boxName);
    await spaNearestBox.put(boxName, page);

    LeLog.rd(this, getNearest, page.toString());
    return page;
  }
}
