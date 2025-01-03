import 'package:hive/hive.dart';
import 'package:kualiva/auth/model/user_model.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/data/dio_client.dart';
import 'package:kualiva/main_hive.dart';

class ProfileRepository {
  ProfileRepository(this._dioClient);

  final DioClient _dioClient;

  Future<UserModel> me() async {
    final userBox = Hive.box<UserModel>(MyHive.user.name);
    LeLog.d(this, 'LeRucco');

    if (userBox.values.toList().isNotEmpty) {
      final user = userBox.values.toList().first;
      LeLog.rd(this, me, user.toString());
      return user;
    }

    final res = await _dioClient.dio().then((dio) {
      return dio.get('/profiles/me');
    });

    final data = UserModel.fromMap(res.data);
    await userBox.clear();
    await userBox.add(data);
    LeLog.rd(this, me, data.toString());
    return data;
  }
}
