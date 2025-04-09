import 'package:hive/hive.dart';
import 'package:kualiva/_data/dio_client.dart';
import 'package:kualiva/_data/enum/paging_enum.dart';
import 'package:kualiva/_data/enum/place_category_enum.dart';
import 'package:kualiva/_data/model/pagination/pagination.dart';
import 'package:kualiva/_data/model/pagination/paging.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/main_hive.dart';
import 'package:kualiva/places/fnb/model/fnb_nearest_model.dart';
import 'package:kualiva/places/fnb/model/fnb_nearest_page.dart';

class FnbNearestRepository {
  FnbNearestRepository(this._dioClient);

  final DioClient _dioClient;

  FnbNearestPage? getNearestOld(String? name) {
    String boxName = MyBox.fnbNearestPage.name;

    if (name != null) {
      boxName = MyBox.fnbNearestSearchPage.name;
    }
    final fnbNearestBox = Hive.box<FnbNearestPage>(boxName);
    return fnbNearestBox.get(boxName);
  }

  Future<FnbNearestPage> getNearest({
    String? name,
    required Paging paging,
    required PagingEnum pagingEnum,
    required double latitude,
    required double longitude,
  }) async {
    String boxName = MyBox.fnbNearestPage.name;

    if (name != null) boxName = MyBox.fnbNearestSearchPage.name;

    final fnbNearestBox = Hive.box<FnbNearestPage>(boxName);

    final oldPage = fnbNearestBox.get(boxName);

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
          'type': PlaceCategoryEnum.fnb.name,
          'name': name
        },
      );
    });
    final page = FnbNearestPage(
      data: (res.data['data'] as List<dynamic>)
          .map((e) => FnbNearestModel.fromMap(e))
          .toList(),
      pagination: Pagination.fromMap(res.data['pagination']),
    );

    if (pagingEnum == PagingEnum.paged) {
      final List<FnbNearestModel> tempList = [
        ...(oldPage?.data ?? []),
        ...page.data
      ];
      page.data.clear();
      page.data.addAll(tempList);
    }

    await fnbNearestBox.delete(boxName);
    await fnbNearestBox.put(boxName, page);

    LeLog.rd(this, getNearest, page.toString());
    return page;
  }
}
