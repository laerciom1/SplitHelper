import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:split_helper/core/domain/entities/category.dart';
import 'package:split_helper/core/domain/entities/settings.dart';
import 'package:split_helper/core/infra/splitwise/splitwise_repository.dart';
import 'package:split_helper/features/split_list/domain/split_data.dart';
import 'package:split_helper/features/split_list/domain/user_split_data.dart';

part 'splits_notifier.freezed.dart';

@freezed
class SplitsState with _$SplitsState {
  const SplitsState._();
  const factory SplitsState.empty() = _Empty;
  const factory SplitsState.initialized({
    required List<SplitData> splits,
  }) = _SplitsState;
  const factory SplitsState.loading() = _Loading;
}

class SplitsNotifier extends StateNotifier<SplitsState> {
  final SplitwiseRepository _splitwiseRepository;
  SplitsNotifier(this._splitwiseRepository) : super(const SplitsState.empty());

  Future<void> getSplits(Settings settings) async {
    state = const SplitsState.loading();
    final selectedGroudId = settings.groups!['${settings.selectedGroup}']!;
    final expenses = await _splitwiseRepository.getExpenses(selectedGroudId);
    final splits = expenses.fold(<SplitData>[], (accu, curr) {
      if (curr.deletedAt == null) {
        final categoryId = curr.category!.id!;
        final category = settings.categories!['$categoryId']!;
        accu.add(
          SplitData.fromExpense(
            expense: curr,
            imageUrl: category.imageUrl!,
            prefix: category.prefix!,
          ),
        );
      }
      return accu;
    }).toList();
    state = SplitsState.initialized(splits: splits);
  }

  Future<void> save({
    required double cost,
    required String description,
    required Category category,
    required int shareConfig,
    required Settings settings,
    required int currentUserId,
  }) async {
    state = const SplitsState.loading();
    final user1OwedShare = cost * (shareConfig / 100);
    final user2OwedShare = cost - user1OwedShare;
    final user1SplitData = UserSplitData(
      userId: currentUserId,
      owedShare: user1OwedShare,
      paidShare: cost,
      balance: cost - user1OwedShare,
    );
    final user2SplitData = UserSplitData(
      userId: settings.splitUsers!['${settings.selectedSplitUser}']!,
      owedShare: user2OwedShare,
      paidShare: 0,
      balance: -user2OwedShare,
    );
    final groupId = settings.groups!['${settings.selectedGroup}']!;
    final shares = [user1SplitData, user2SplitData];
    await _splitwiseRepository.addSplit(
      cost: cost,
      description: description,
      category: category,
      shareConfig: shareConfig,
      settings: settings,
      currentUserId: currentUserId,
      groupId: groupId,
      shares: shares,
    );
    await getSplits(settings);
  }
}
