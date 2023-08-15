// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_expense_request.freezed.dart';
part 'create_expense_request.g.dart';

@freezed
class CreateExpenseRequest with _$CreateExpenseRequest {
  const factory CreateExpenseRequest({
    @JsonKey(name: "cost") required String cost,
    @JsonKey(name: "description") required String description,
    @JsonKey(name: "date") required DateTime date,
    @JsonKey(name: "category_id") required int categoryId,
    @JsonKey(name: "group_id") required int groupId,
    @JsonKey(name: "users__0__user_id") required int users0UserId,
    @JsonKey(name: "users__0__paid_share") required String users0PaidShare,
    @JsonKey(name: "users__0__owed_share") required String users0OwedShare,
    @JsonKey(name: "users__1__user_id") required int users1UserId,
    @JsonKey(name: "users__1__paid_share") required String users1PaidShare,
    @JsonKey(name: "users__1__owed_share") required String users1OwedShare,
    @Default('BRL') @JsonKey(name: "currency_code") String currencyCode,
  }) = _CreateExpenseRequest;

  factory CreateExpenseRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateExpenseRequestFromJson(json);
}
