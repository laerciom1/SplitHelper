// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_expense_response.freezed.dart';
part 'create_expense_response.g.dart';

@freezed
class CreateExpenseResponse with _$CreateExpenseResponse {
  const factory CreateExpenseResponse({
    @JsonKey(name: "expenses") List<Expense>? expenses,
    @JsonKey(name: "errors") Errors? errors,
  }) = _CreateExpenseResponse;

  factory CreateExpenseResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateExpenseResponseFromJson(json);
}

@freezed
class Errors with _$Errors {
  const factory Errors() = _Errors;

  factory Errors.fromJson(Map<String, dynamic> json) => _$ErrorsFromJson(json);
}

@freezed
class Expense with _$Expense {
  const factory Expense({
    @JsonKey(name: "cost") String? cost,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "details") String? details,
    @JsonKey(name: "date") DateTime? date,
    @JsonKey(name: "repeat_interval") String? repeatInterval,
    @JsonKey(name: "currency_code") String? currencyCode,
    @JsonKey(name: "category_id") int? categoryId,
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "group_id") int? groupId,
    @JsonKey(name: "friendship_id") int? friendshipId,
    @JsonKey(name: "expense_bundle_id") int? expenseBundleId,
    @JsonKey(name: "repeats") bool? repeats,
    @JsonKey(name: "email_reminder") bool? emailReminder,
    @JsonKey(name: "email_reminder_in_advance") dynamic emailReminderInAdvance,
    @JsonKey(name: "next_repeat") String? nextRepeat,
    @JsonKey(name: "comments_count") int? commentsCount,
    @JsonKey(name: "payment") bool? payment,
    @JsonKey(name: "transaction_confirmed") bool? transactionConfirmed,
    @JsonKey(name: "repayments") List<Repayment>? repayments,
    @JsonKey(name: "created_at") DateTime? createdAt,
    @JsonKey(name: "created_by") CreatedBy? createdBy,
    @JsonKey(name: "updated_at") DateTime? updatedAt,
    @JsonKey(name: "updated_by") UpdatedBy? updatedBy,
    @JsonKey(name: "deleted_at") DateTime? deletedAt,
    @JsonKey(name: "deleted_by") DeletedBy? deletedBy,
    @JsonKey(name: "category") Category? category,
    @JsonKey(name: "receipt") Receipt? receipt,
    @JsonKey(name: "users") List<UserElement>? users,
    @JsonKey(name: "comments") List<Comment>? comments,
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
class Comment with _$Comment {
  const factory Comment({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "content") String? content,
    @JsonKey(name: "comment_type") String? commentType,
    @JsonKey(name: "relation_type") String? relationType,
    @JsonKey(name: "relation_id") int? relationId,
    @JsonKey(name: "created_at") DateTime? createdAt,
    @JsonKey(name: "deleted_at") DateTime? deletedAt,
    @JsonKey(name: "user") CommentUser? user,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}

@freezed
class CommentUser with _$CommentUser {
  const factory CommentUser({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "first_name") String? firstName,
    @JsonKey(name: "last_name") String? lastName,
    @JsonKey(name: "picture") UserPicture? picture,
  }) = _CommentUser;

  factory CommentUser.fromJson(Map<String, dynamic> json) =>
      _$CommentUserFromJson(json);
}

@freezed
class UserPicture with _$UserPicture {
  const factory UserPicture({
    @JsonKey(name: "medium") String? medium,
  }) = _UserPicture;

  factory UserPicture.fromJson(Map<String, dynamic> json) =>
      _$UserPictureFromJson(json);
}

@freezed
class CreatedBy with _$CreatedBy {
  const factory CreatedBy({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "first_name") String? firstName,
    @JsonKey(name: "last_name") String? lastName,
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "registration_status") String? registrationStatus,
    @JsonKey(name: "picture") CreatedByPicture? picture,
  }) = _CreatedBy;

  factory CreatedBy.fromJson(Map<String, dynamic> json) =>
      _$CreatedByFromJson(json);
}

@freezed
class CreatedByPicture with _$CreatedByPicture {
  const factory CreatedByPicture({
    @JsonKey(name: "small") String? small,
    @JsonKey(name: "medium") String? medium,
    @JsonKey(name: "large") String? large,
  }) = _CreatedByPicture;

  factory CreatedByPicture.fromJson(Map<String, dynamic> json) =>
      _$CreatedByPictureFromJson(json);
}

@freezed
class DeletedBy with _$DeletedBy {
  const factory DeletedBy({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "first_name") String? firstName,
    @JsonKey(name: "last_name") String? lastName,
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "registration_status") String? registrationStatus,
    @JsonKey(name: "picture") CreatedByPicture? picture,
  }) = _DeletedBy;

  factory DeletedBy.fromJson(Map<String, dynamic> json) =>
      _$DeletedByFromJson(json);
}

@freezed
class Receipt with _$Receipt {
  const factory Receipt({
    @JsonKey(name: "large") String? large,
    @JsonKey(name: "original") String? original,
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
class UpdatedBy with _$UpdatedBy {
  const factory UpdatedBy({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "first_name") String? firstName,
    @JsonKey(name: "last_name") String? lastName,
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "registration_status") String? registrationStatus,
    @JsonKey(name: "picture") CreatedByPicture? picture,
  }) = _UpdatedBy;

  factory UpdatedBy.fromJson(Map<String, dynamic> json) =>
      _$UpdatedByFromJson(json);
}

@freezed
class UserElement with _$UserElement {
  const factory UserElement({
    @JsonKey(name: "user") UserUser? user,
    @JsonKey(name: "user_id") int? userId,
    @JsonKey(name: "paid_share") String? paidShare,
    @JsonKey(name: "owed_share") String? owedShare,
    @JsonKey(name: "net_balance") String? netBalance,
  }) = _UserElement;

  factory UserElement.fromJson(Map<String, dynamic> json) =>
      _$UserElementFromJson(json);
}

@freezed
class UserUser with _$UserUser {
  const factory UserUser({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "first_name") String? firstName,
    @JsonKey(name: "last_name") String? lastName,
    @JsonKey(name: "picture") UserPicture? picture,
  }) = _UserUser;

  factory UserUser.fromJson(Map<String, dynamic> json) =>
      _$UserUserFromJson(json);
}
