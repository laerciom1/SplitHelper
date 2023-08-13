import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:split_helper/features/auth/infra/credentials_storage/secure_credentials_storage.dart';

final flutterSecureStorageProvider =
    Provider((ref) => const FlutterSecureStorage());

final dioProvider = Provider((ref) => Dio());

final credentialsStorageProvider = Provider(
  (ref) => SecureCredentialsStorage(ref.watch(flutterSecureStorageProvider)),
);
