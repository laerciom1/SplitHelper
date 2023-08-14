import 'package:firebase_database/firebase_database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'config_notifier.freezed.dart';

@freezed
class ConfigState with _$ConfigState {
  const ConfigState._();
  const factory ConfigState.empty() = _Empty;
  const factory ConfigState.initialized({
    required String consumerKey,
    required String consumerSecret,
  }) = _ConfigState;
  const factory ConfigState.failure() = _Failure;
}

class ConfigNotifier extends StateNotifier<ConfigState> {
  ConfigNotifier() : super(const ConfigState.empty());

  Future<void> initializeConfig() async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final value = (await ref.child('_splitwiseConfig').get()).value!
          as Map<Object?, Object?>;
      state = ConfigState.initialized(
        consumerKey: value['consumerKey']! as String,
        consumerSecret: value['consumerSecret']! as String,
      );
    } catch (_) {
      state = const ConfigState.failure();
    }
  }

  String? get consumerKey => state.whenOrNull(initialized: (key, _) => key);
  String? get consumerSecret =>
      state.whenOrNull(initialized: (_, secret) => secret);
}
