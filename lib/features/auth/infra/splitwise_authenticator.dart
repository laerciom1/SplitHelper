import 'package:dartz/dartz.dart';
import 'package:oauth2/oauth2.dart';
import 'package:split_helper/core/infra/storage.dart';
import 'package:split_helper/features/auth/domain/auth_failure.dart';

class SplitwiseAuthenticator {
  static final authEndpoint =
      Uri.parse('https://secure.splitwise.com/oauth/authorize');
  static final tokenEndpoint =
      Uri.parse('https://secure.splitwise.com/oauth/token');
  static final redirectUrl = Uri.parse('http://localhost:8080/oauth2/callback');

  final SecureStorage _storage;

  SplitwiseAuthenticator(this._storage);

  Future<Credentials?> getSignedInCredentials() async {
    try {
      final storedCredentialsJson =
          await _storage.read(SecureStorage.authCredentialsKey);
      if (storedCredentialsJson != null) {
        final storedCredentials = Credentials.fromJson(storedCredentialsJson);
        return storedCredentials;
      }
    } catch (_) {}
    return null;
  }

  Future<bool> isSignedIn() =>
      getSignedInCredentials().then((credentials) => credentials != null);

  AuthorizationCodeGrant getCodeGrant(String key, String secret) {
    return AuthorizationCodeGrant(
      key,
      authEndpoint,
      tokenEndpoint,
      secret: secret,
      basicAuth: false,
    );
  }

  Uri getAuthURL(AuthorizationCodeGrant grant) =>
      grant.getAuthorizationUrl(redirectUrl);

  Future<Either<AuthFailure, Unit>> handleAuthResponse(
    AuthorizationCodeGrant grant,
    Map<String, String> queryParams,
  ) async {
    try {
      final credentials =
          (await grant.handleAuthorizationResponse(queryParams)).credentials;
      await _storage.save(
        SecureStorage.authCredentialsKey,
        credentials.toJson(),
      );
      return right(unit);
    } catch (e) {
      return left(AuthFailure.general('$e'));
    }
  }

  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      await _storage.clear();
      return right(unit);
    } catch (e) {
      return left(AuthFailure.general('$e'));
    }
  }
}
