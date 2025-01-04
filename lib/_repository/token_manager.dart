import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kualiva/common/utility/lelog.dart';

class TokenManager {
  TokenManager(this._storage) {
    // readAccessToken();
    // readRefreshToken();
  }

  final FlutterSecureStorage _storage;

  // String? _accessToken;
  // String? _refreshToken;

  // String? get accessToken => _accessToken;

  // String? get refreshToken => _refreshToken;

  String _getAccessKey() {
    return dotenv.get("ACCESS_TOKEN_KEY", fallback: null);
  }

  String _getRefreshKey() {
    return dotenv.get("REFRESH_TOKEN_KEY", fallback: null);
  }

  Future<String?> readToken() async {
    // deleteToken();
    return await readAccessToken() ?? await readRefreshToken();
  }

  /// Logout
  Future<List<String>> deleteToken() async {
    LeLog.rd(this, deleteToken, 'Delete Access and Refresh Token');
    return Future.wait([deleteAccessToken(), deleteRefreshToken()]);
  }

  Future<String?> readAccessToken() async {
    // _accessToken = await _storage.read(key: _getAccessKey());
    // return _accessToken;
    String? token = await _storage.read(key: _getAccessKey());
    LeLog.rd(this, readAccessToken, token.toString());
    return token;
  }

  Future<String?> readRefreshToken() async {
    // _refreshToken = await _storage.read(key: _getRefreshKey());
    // return _refreshToken;
    String? token = await _storage.read(key: _getRefreshKey());
    LeLog.rd(this, readRefreshToken, token.toString());
    return token;
  }

  Future<void> writeAccessToken(String accessToken) async {
    // _accessToken = accessToken;
    LeLog.rd(this, readRefreshToken, accessToken.toString());
    await _storage.write(key: _getAccessKey(), value: accessToken);
  }

  Future<void> writeRefreshToken(String refreshToken) async {
    // _refreshToken = refreshToken;
    LeLog.rd(this, readRefreshToken, refreshToken.toString());
    await _storage.write(key: _getRefreshKey(), value: refreshToken);
  }

  Future<String> deleteAccessToken() async {
    if (await readAccessToken() == null) return 'Access Token not exist';
    await _storage.delete(key: _getAccessKey());
    LeLog.rd(this, readRefreshToken, 'Delete Access Token');
    return '';
  }

  Future<String> deleteRefreshToken() async {
    if (await readRefreshToken() == null) return 'Refresh Token not exist';
    LeLog.rd(this, deleteRefreshToken, 'Delete Refresh Token');
    await _storage.delete(key: _getRefreshKey());
    return '';
  }
}
