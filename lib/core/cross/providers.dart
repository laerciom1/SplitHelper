import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:split_helper/core/application/config_notifier.dart';
import 'package:split_helper/core/infra/storage.dart';

final flutterSecureStorageProvider =
    Provider((ref) => const FlutterSecureStorage());

final dioProvider = Provider((ref) => Dio());

final secureStorageProvider = Provider(
  (ref) => SecureStorage(ref.watch(flutterSecureStorageProvider)),
);

final configNotifierProvider =
    StateNotifierProvider<ConfigNotifier, ConfigState>(
  (ref) => ConfigNotifier(),
);
