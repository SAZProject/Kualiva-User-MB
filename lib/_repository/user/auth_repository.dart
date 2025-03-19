import 'package:dio/dio.dart';
import 'package:kualiva/_data/error_handler.dart';
import 'package:kualiva/_repository/common/token_manager.dart';
import 'package:kualiva/auth/model/user_model.dart';
import 'package:kualiva/common/utility/lelog.dart';
import 'package:kualiva/_data/dio_client.dart';

class AuthRepository {
  AuthRepository(this._tokenManager, this._dioClient);

  final DioClient _dioClient;
  final TokenManager _tokenManager;

  Future<bool> checkToken() async {
    String? token = await _tokenManager.readToken();
    if (token == null) return false;
    return true;
  }

  Future<UserModel> login({
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
    final accessToken = res.data['data']['accessToken'].toString();
    final refreshToken = res.data['data']['refreshToken'].toString();
    LeLog.rd(this, login, res.data['data'].toString());

    await Future.wait([
      _tokenManager.writeAccessToken(accessToken),
      _tokenManager.writeRefreshToken(refreshToken),
    ], eagerError: true);

    LeLog.rd(this, login, 'Login Success');

    return UserModel.fromMap(res.data['data']['user'] as Map<String, dynamic>);
  }

  Future<UserModel> register({
    required String username,
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    try {
      final res = await _dioClient.dio().then((dio) {
        return dio.post('/auth/register', data: {
          'username': username,
          'phone': phoneNumber,
          'email': email,
          'password': password,
        });
      });

      final accessToken = res.data['data']['accessToken'].toString();
      final refreshToken = res.data['data']['refreshToken'].toString();

      await Future.wait([
        _tokenManager.writeAccessToken(accessToken),
        _tokenManager.writeRefreshToken(refreshToken),
      ], eagerError: true);

      LeLog.rd(this, register, 'Register Success');

      return UserModel.fromMap(
          res.data['data']['user'] as Map<String, dynamic>);
    } on DioException catch (e) {
      final failure = ErrorHandler.handle(e).failure;
      LeLog.re(this, register, failure.toString());
      throw failure;
    }
  }
}
