import 'package:like_it/auth/model/user_model.dart';
import 'package:like_it/data/dio_client.dart';

class AuthRepository {
  AuthRepository(this._dioClient);

  final DioClient _dioClient;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final _ = await _dioClient.dio().then((dio) {
      return dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
    });
    return;
  }

  Future<UserModel> register({
    required String username,
    required String phoneNumber,
    required String password,
  }) async {
    final res = await _dioClient.dio().then((dio) {
      return dio.post('/auth/register', data: {
        'username': username,
        'phone': phoneNumber,
        'password': password,
      });
    });

    return UserModel.fromMap(res.data);
  }
}
