import 'package:like_it/data/dio_client.dart';

class AuthRepository {
  AuthRepository(this._dioClient);

  final DioClient _dioClient;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final _ = await _dioClient.dio().then((dio) {
      return dio.post('/api/v1/auth/login', data: {
        'email': email,
        'password': password,
      });
    });
    return;
  }
}
