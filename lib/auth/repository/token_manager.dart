import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  TokenManager(this._storage);

  final FlutterSecureStorage _storage;

  String? _accessToken;
  String? _refreshToken;

  String? get accessToken => _accessToken;

  String? get refreshToken => _refreshToken;

  String _getAccessKey() {
    return dotenv.get("ACCESS_TOKEN_KEY", fallback: null);
  }

  String _getRefreshKey() {
    return dotenv.get("REFRESH_TOKEN_KEY", fallback: null);
  }

  Future<String?> readAccessToken() async {
    _accessToken = await _storage.read(key: _getAccessKey());
    return _accessToken;
  }

  Future<String?> readRefreshToken() async {
    _refreshToken = await _storage.read(key: _getRefreshKey());
    return _refreshToken;
  }

  Future<void> writeAccessToken(String accessToken) async {
    _accessToken = accessToken;
    await _storage.write(key: _getAccessKey(), value: accessToken);
  }

  Future<void> writeRefreshToken(String refreshToken) async {
    _refreshToken = refreshToken;
    await _storage.write(key: _getRefreshKey(), value: refreshToken);
  }

  Future<String> deleteAccessToken() async {
    if (await readAccessToken() == null) return 'Access Token not exist';
    await _storage.delete(key: _getAccessKey());
    return '';
  }

  Future<String> deleteRefreshToken() async {
    if (await readRefreshToken() == null) return 'Refresh Token not exist';
    await _storage.delete(key: _getRefreshKey());
    return '';
  }

  Future<void> deleteAllToken() async {
    await _storage.deleteAll();
  }
}
