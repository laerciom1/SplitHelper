import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:split_helper/core/domain/entities/category.dart';
import 'package:split_helper/features/split_list/domain/user_split_data.dart';

part 'splits_notifier.freezed.dart';

@freezed
class SplitsState with _$SplitsState {
  const SplitsState._();
  const factory SplitsState.empty() = _Empty;
  const factory SplitsState.initialized({
    required String consumerKey,
    required String consumerSecret,
  }) = _SplitsState;
}

class SplitsNotifier extends StateNotifier<SplitsState> {
  SplitsNotifier() : super(const SplitsState.empty());

  Future<void> getSplits() async {
    return;
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
