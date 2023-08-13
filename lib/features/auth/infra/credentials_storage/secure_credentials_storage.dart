import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:oauth2/oauth2.dart';
import 'package:split_helper/features/auth/infra/credentials_storage/credentials_storage.dart';

class SecureCredentialsStorage implements CredentialsStorage {
  final FlutterSecureStorage _storage;

  SecureCredentialsStorage(this._storage);

  static const String _key = 'oauth2_credentials';

  Credentials? _cachedCredentials;

  @override
  Future<Credentials?> read() async {
    if (_cachedCredentials != null) return _cachedCredentials!;
    final json = await _storage.read(key: _key);
    if (json == null) return null;
    return _cachedCredentials = Credentials.fromJson(json);
  }

  @override
  Future<void> save(Credentials credentials) {
    _cachedCredentials = credentials;
    return _storage.write(
      key: _key,
      value: credentials.toJson(),
    );
  }

  @override
  Future<void> clear() async {
    _cachedCredentials = null;
    _storage.delete(key: _key);
  }
}
