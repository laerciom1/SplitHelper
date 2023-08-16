import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:split_helper/core/application/config_notifier.dart';
import 'package:split_helper/core/application/session_notifier.dart';
import 'package:split_helper/core/infra/firebase/firebase_repository.dart';
import 'package:split_helper/core/infra/splitwise/splitwise_repository.dart';
import 'package:split_helper/core/infra/storage.dart';
import 'package:split_helper/features/auth/application/auth_notifier.dart';
import 'package:split_helper/features/auth/infra/splitwise_authenticator.dart';

final flutterSecureStorageProvider =
    Provider((ref) => const FlutterSecureStorage());

final dioProvider = Provider((ref) {
  return Dio();
});

final secureStorageProvider = Provider(
  (ref) => SecureStorage(ref.watch(flutterSecureStorageProvider)),
);

final splitwiseAuthenticatorProvider = Provider(
  (ref) => SplitwiseAuthenticator(ref.watch(secureStorageProvider)),
);

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.watch(splitwiseAuthenticatorProvider)),
);

final firebaseRepositoryProvider = Provider(
  (ref) => FirebaseRepository(),
);

final splitwiseRepositoryProvider = Provider(
  (ref) => SplitwiseRepository(
    ref.watch(secureStorageProvider),
    ref.watch(authNotifierProvider.notifier),
  ),
);

final configNotifierProvider =
    StateNotifierProvider<ConfigNotifier, ConfigState>(
  (ref) => ConfigNotifier(ref.watch(firebaseRepositoryProvider)),
);

final sessionNotifierProvider =
    StateNotifierProvider<SessionNotifier, SessionState>(
  (ref) => SessionNotifier(
    ref.watch(firebaseRepositoryProvider),
    ref.watch(splitwiseRepositoryProvider),
  ),
);
