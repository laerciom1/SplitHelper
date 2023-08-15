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
        accu.add(SplitData.fromExpense(
          expense: curr,
          imageUrl: category.imageUrl!,
          prefix: category.prefix!,
        ));
      }
      return accu;
    }).toList();
    state = SplitsState.initialized(splits: splits);
  }

  /*
    {
      "cost": "100",
      "description": "TEST",
      "group_id": 001122,
      "date": "2023-08-02T15:00:00Z",
      "currency_code": "BRL",
      "category_id": 13,
      "users__0__user_id": 123,
      "users__0__paid_share": "100",
      "users__0__owed_share": "85",
      "users__1__user_id": 321,
      "users__1__paid_share": "0",
      "users__1__owed_share": "15"
    }
  */
  Future<void> save({
    required double cost,
    required String description,
    required Category category,
    required int shareConfig,
    required int groupId, // Firebase
    required List<UserSplitData> shares, // Id do Firebase e Valores do Input
    // DateTime date, // NOW
    // String currencyCode, // BRL
  }) async {
    return;
  }

  Future<void> updateSplits() async {
    return;
  }
}
