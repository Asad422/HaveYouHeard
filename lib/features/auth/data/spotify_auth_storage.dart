import 'package:hive_flutter/hive_flutter.dart';

class SpotifyAuthStorage {
  static const String _boxName = 'spotify_auth';
  static const String _refreshTokenKey = 'refresh_token';

  Future<Box> _box() => Hive.openBox(_boxName);

  Future<String?> getRefreshToken() async {
    final box = await _box();
    return box.get(_refreshTokenKey) as String?;
  }

  Future<void> saveRefreshToken(String token) async {
    final box = await _box();
    await box.put(_refreshTokenKey, token);
  }

  Future<void> clearRefreshToken() async {
    final box = await _box();
    await box.delete(_refreshTokenKey);
  }
}
