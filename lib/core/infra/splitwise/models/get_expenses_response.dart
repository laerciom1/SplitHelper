// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_expenses_response.freezed.dart';
part 'get_expenses_response.g.dart';

@freezed
class GetExpensesResponse with _$GetExpensesResponse {
  const factory GetExpensesResponse({
    @JsonKey(name: "expenses") List<Expense>? expenses,
  }) = _GetExpensesResponse;

  factory GetExpensesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetExpensesResponseFromJson(json);
}

@freezed
class Expense with _$Expense {
  const factory Expense({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "group_id") int? groupId,
    @JsonKey(name: "friendship_id") dynamic friendshipId,
    @JsonKey(name: "expense_bundle_id") dynamic expenseBundleId,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "repeats") bool? repeats,
    @JsonKey(name: "repeat_interval") dynamic repeatInterval,
    @JsonKey(name: "email_reminder") bool? emailReminder,
    @JsonKey(name: "email_reminder_in_advance") int? emailReminderInAdvance,
    @JsonKey(name: "next_repeat") dynamic nextRepeat,
    @JsonKey(name: "details") String? details,
    @JsonKey(name: "comments_count") int? commentsCount,
    @JsonKey(name: "payment") bool? payment,
    @JsonKey(name: "creation_method") String? creationMethod,
    @JsonKey(name: "transaction_method") String? transactionMethod,
    @JsonKey(name: "transaction_confirmed") bool? transactionConfirmed,
    @JsonKey(name: "transaction_id") dynamic transactionId,
    @JsonKey(name: "transaction_status") dynamic transactionStatus,
    @JsonKey(name: "cost") String? cost,
    @JsonKey(name: "currency_code") String? currencyCode,
    @JsonKey(name: "repayments") List<Repayment>? repayments,
    @JsonKey(name: "date") DateTime? date,
    @JsonKey(name: "created_at") DateTime? createdAt,
    @JsonKey(name: "created_by") CreatedBy? createdBy,
    @JsonKey(name: "updated_at") DateTime? updatedAt,
    @JsonKey(name: "updated_by") TedBy? updatedBy,
    @JsonKey(name: "deleted_at") DateTime? deletedAt,
    @JsonKey(name: "deleted_by") TedBy? deletedBy,
    @JsonKey(name: "category") Category? category,
    @JsonKey(name: "receipt") Receipt? receipt,
    @JsonKey(name: "users") List<UserElement>? users,
  }) = _Expense;

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);
}

@freezed
class Category with _$Category {
  const factory Category({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "name") String? name,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

@freezed
class CreatedBy with _$CreatedBy {
  const factory CreatedBy({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "first_name") String? firstName,
    @JsonKey(name: "last_name") String? lastName,
    @JsonKey(name: "picture") CreatedByPicture? picture,
    @JsonKey(name: "custom_picture") bool? customPicture,
  }) = _CreatedBy;

  factory CreatedBy.fromJson(Map<String, dynamic> json) =>
      _$CreatedByFromJson(json);
}

@freezed
class CreatedByPicture with _$CreatedByPicture {
  const factory CreatedByPicture({
    @JsonKey(name: "medium") String? medium,
  }) = _CreatedByPicture;

  factory CreatedByPicture.fromJson(Map<String, dynamic> json) =>
      _$CreatedByPictureFromJson(json);
}

@freezed
class TedBy with _$TedBy {
  const factory TedBy({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "first_name") String? firstName,
    @JsonKey(name: "last_name") dynamic lastName,
    @JsonKey(name: "picture") DeletedByPicture? picture,
    @JsonKey(name: "custom_picture") bool? customPicture,
  }) = _TedBy;

  factory TedBy.fromJson(Map<String, dynamic> json) => _$TedByFromJson(json);
}

@freezed
class DeletedByPicture with _$DeletedByPicture {
  const factory DeletedByPicture({
    @JsonKey(name: "medium") String? medium,
  }) = _DeletedByPicture;

  factory DeletedByPicture.fromJson(Map<String, dynamic> json) =>
      _$DeletedByPictureFromJson(json);
}

@freezed
class Receipt with _$Receipt {
  const factory Receipt({
    @JsonKey(name: "large") dynamic large,
    @JsonKey(name: "original") dynamic original,
  }) = _Receipt;

  factory Receipt.fromJson(Map<String, dynamic> json) =>
      _$ReceiptFromJson(json);
}

@freezed
class Repayment with _$Repayment {
  const factory Repayment({
    @JsonKey(name: "from") int? from,
    @JsonKey(name: "to") int? to,
    @JsonKey(name: "amount") String? amount,
  }) = _Repayment;

  factory Repayment.fromJson(Map<String, dynamic> json) =>
      _$RepaymentFromJson(json);
}

@freezed
class UserElement with _$UserElement {
  const factory UserElement({
    @JsonKey(name: "user") User? user,
    @JsonKey(name: "user_id") int? userId,
    @JsonKey(name: "paid_share") String? paidShare,
    @JsonKey(name: "owed_share") String? owedShare,
    @JsonKey(name: "net_balance") String? netBalance,
  }) = _UserElement;

  factory UserElement.fromJson(Map<String, dynamic> json) =>
      _$UserElementFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "first_name") String? firstName,
    @JsonKey(name: "last_name") String? lastName,
    @JsonKey(name: "picture") CreatedByPicture? picture,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
