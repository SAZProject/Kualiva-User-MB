import 'package:kualiva/repository/token_manager.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/data/dio_client.dart';

class AuthRepository {
  AuthRepository(this._tokenManager, this._dioClient);

  final DioClient _dioClient;
  final TokenManager _tokenManager;

  Future<bool> checkToken() async {
    String? token = await _tokenManager.readToken();
    if (token == null) return false;
    return true;
  }

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
    ], eagerError: true);
    LeLog.rd(this, login, 'Login Success');
  }

  Future<void> register({
    required String username,
    required String phoneNumber,
    required String password,
  }) async {
    final _ = await _dioClient.dio().then((dio) {
      return dio.post('/auth/register', data: {
        'username': username,
        'phone': phoneNumber,
        'password': password,
      });
    });

    LeLog.rd(this, register, 'Register Success');
  }
}
