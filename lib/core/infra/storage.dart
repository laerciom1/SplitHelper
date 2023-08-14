import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage;
  SecureStorage(this._storage);

  static const String authCredentialsKey = 'oauth2_credentials';

  final Map<String, String> _cache = {};

  Future<String?> read(String key) async {
    if (_cache[key] != null) return _cache[key];
    final json = await _storage.read(key: key);
    if (json == null) return null;
    return json;
  }

  Future<void> save(String key, String value) {
    _cache[key] = value;
    return _storage.write(
      key: key,
      value: value,
    );
  }

  Future<void> clear() async {
    _cache.clear();
    _storage.delete(key: authCredentialsKey);
  }
}
