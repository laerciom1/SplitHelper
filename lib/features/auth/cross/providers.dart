import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:split_helper/core/cross/providers.dart';
import 'package:split_helper/features/auth/application/auth_notifier.dart';
import 'package:split_helper/features/auth/infra/splitwise_authenticator.dart';

final splitwiseAuthenticatorProvider = Provider(
  (ref) => SplitwiseAuthenticator(ref.watch(credentialsStorageProvider)),
);

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.watch(splitwiseAuthenticatorProvider)),
);
