import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:split_helper/core/domain/entities/settings.dart';
import 'package:split_helper/core/infra/firebase/firebase_repository.dart';
import 'package:split_helper/core/infra/splitwise/splitwise_repository.dart';

part 'session_notifier.freezed.dart';

@freezed
class SessionState with _$SessionState {
  const SessionState._();
  const factory SessionState.empty() = _Empty;
  const factory SessionState.initialized({
    required int currentUserId,
    required Settings settings,
  }) = _SessionState;
  const factory SessionState.failure() = _Failure;
}

class SessionNotifier extends StateNotifier<SessionState> {
  final FirebaseRepository _firebaseRepository;
  final SplitwiseRepository _splitwiseRepository;
  SessionNotifier(
    this._firebaseRepository,
    this._splitwiseRepository,
  ) : super(const SessionState.empty());

  Future<SessionState> initializeSession() async {
    try {
      final currentUser = await _splitwiseRepository.getCurrentUser();
      final currentUserId = currentUser.user!.id!;
      final currentSetting = await _firebaseRepository.getSettings(
        userId: '$currentUserId',
      );
      return state = SessionState.initialized(
        currentUserId: currentUserId,
        settings: currentSetting,
      );
    } catch (_) {
      return state = const SessionState.failure();
    }
  }
}
