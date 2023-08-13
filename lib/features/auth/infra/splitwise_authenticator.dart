import 'package:dartz/dartz.dart';
import 'package:oauth2/oauth2.dart';
import 'package:split_helper/features/auth/domain/auth_failure.dart';
import 'package:split_helper/features/auth/infra/credentials_storage/credentials_storage.dart';

class SplitwiseAuthenticator {

  final CredentialsStorage _credentialsStorage;

  SplitwiseAuthenticator(this._credentialsStorage);

  Future<Credentials?> getSignedInCredentials() async {
    try {
      final storedCredentials = await _credentialsStorage.read();
      if (storedCredentials != null) {
        if (storedCredentials.canRefresh && storedCredentials.isExpired) {
          final failureOrCredentials = await refresh(storedCredentials);
          return failureOrCredentials.fold(
            (failure) => null,
            (credentials) => credentials,
          );
        }
        return storedCredentials;
      }
    } catch (_) {}
    return null;
  }

  Future<bool> isSignedIn() =>
      getSignedInCredentials().then((credentials) => credentials != null);

  AuthorizationCodeGrant getCodeGrant() => AuthorizationCodeGrant(
        consumerKey,
        authEndpoint,
        tokenEndpoint,
        secret: consumerSecret,
        basicAuth: false,
      );

  Uri getAuthURL(AuthorizationCodeGrant grant) =>
      grant.getAuthorizationUrl(redirectUrl);

  Future<Either<AuthFailure, Unit>> handleAuthResponse(
    AuthorizationCodeGrant grant,
    Map<String, String> queryParams,
  ) async {
    try {
      final credentials =
          (await grant.handleAuthorizationResponse(queryParams)).credentials;
      await _credentialsStorage.save(credentials);
      return right(unit);
    } catch (e) {
      return left(AuthFailure.general('$e'));
    }
  }

  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      await _credentialsStorage.clear();
      return right(unit);
    } catch (e) {
      return left(AuthFailure.general('$e'));
    }
  }

  Future<Either<AuthFailure, Credentials>> refresh(
    Credentials credentials,
  ) async {
    try {
      final freshCredentials = await credentials.refresh(
        identifier: consumerKey,
        secret: consumerSecret,
      );
      await _credentialsStorage.save(freshCredentials);
      return right(freshCredentials);
    } catch (e) {
      return left(AuthFailure.general('$e'));
    }
  }
}
