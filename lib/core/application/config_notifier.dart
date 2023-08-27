import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:split_helper/core/infra/firebase/firebase_wrapper.dart';
import 'package:split_helper/features/auth/domain/config.dart';

part 'config_notifier.freezed.dart';

@freezed
class ConfigState with _$ConfigState {
  const ConfigState._();
  const factory ConfigState.empty() = _Empty;
  const factory ConfigState.initialized({
    required Config config,
  }) = _ConfigState;
  const factory ConfigState.failure() = _Failure;
}

class ConfigNotifier extends StateNotifier<ConfigState> {
  final FirebaseWrapper _firebaseRepository;
  ConfigNotifier(this._firebaseRepository) : super(const ConfigState.empty());

  Future<void> initializeConfig() async {
    try {
      final config = await _firebaseRepository.getConfig();
      state = ConfigState.initialized(config: config);
    } catch (_) {
      state = const ConfigState.failure();
    }
  }

  String? get consumerKey =>
      state.whenOrNull(initialized: (config) => config.consumerKey);
  String? get consumerSecret =>
      state.whenOrNull(initialized: (config) => config.consumerSecret);
}
