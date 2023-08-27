import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:split_helper/core/infra/firebase/firebase_wrapper.dart';
import 'package:split_helper/features/auth/domain/auth_failure.dart';
import 'package:split_helper/features/auth/infra/splitwise_authenticator.dart';

part 'auth_notifier.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();
  const factory AuthState.initial() = _Initial;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.authenticated() = _Authenticated;
  const factory AuthState.failure(AuthFailure failure) = _Failure;
}

class AuthNotifier extends StateNotifier<AuthState> {
  final SplitwiseAuthenticator _authenticator;
  final FirebaseWrapper _firebaseWrapper;
  AuthNotifier(this._authenticator, this._firebaseWrapper)
      : super(const AuthState.initial());

  Future<void> checkAndUpdateStatus() async {
    final isSignedIn =
        await _authenticator.isSignedIn() && _firebaseWrapper.isSignedIn();
    state = isSignedIn
        ? const AuthState.authenticated()
        : const AuthState.unauthenticated();
  }

  Future<void> signIn(
    String key,
    String secret,
    AuthUriCallback authCallback,
  ) async {
    final grant = _authenticator.getCodeGrant(key, secret);
    final redirectUrl = await authCallback(_authenticator.getAuthURL(grant));
    final failureOrSuccess = await _authenticator.handleAuthResponse(
      grant,
      redirectUrl.queryParameters,
    );
    state = failureOrSuccess.fold(
      (failure) => AuthState.failure(failure),
      (_) => const AuthState.authenticated(),
    );
    grant.close();
  }

  Future<void> signOut() async {
    final failureOrSuccess = await _authenticator.signOut();
    state = failureOrSuccess.fold(
      (failure) => AuthState.failure(failure),
      (_) => const AuthState.unauthenticated(),
    );
  }
}

typedef AuthUriCallback = Future<Uri> Function(Uri authUrl);
