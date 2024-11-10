import 'package:like_it/auth/model/user_model.dart';
import 'package:like_it/auth/repository/token_manager.dart';
import 'package:like_it/data/dio_client.dart';

class AuthRepository {
  AuthRepository(this._tokenManager, this._dioClient);

  final DioClient _dioClient;
  final TokenManager _tokenManager;

  Future<void> login({
    required String? username,
    required String? phoneNumber,
    required String password,
  }) async {
    Map<String, String> body = {};
    body.addAll({'password': password});
    if (username != null) {
      body.addAll({'username': username});
    }
    if (phoneNumber != null) {
      body.addAll({'phone': phoneNumber});
    }
    final res = await _dioClient.dio().then((dio) {
      return dio.post('/auth/login', data: body);
    });
    final accessToken = res.data['accessToken'].toString();
    final refreshToken = res.data['refreshToken'].toString();

    await Future.wait([
      _tokenManager.writeAccessToken(accessToken),
      _tokenManager.writeRefreshToken(refreshToken),
    ]);

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
