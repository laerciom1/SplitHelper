// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_current_user_response.freezed.dart';
part 'get_current_user_response.g.dart';

GetCurrentUserResponse getCurrentUserResponseFromJson(String str) =>
    GetCurrentUserResponse.fromJson(json.decode(str) as Map<String, dynamic>);

String getCurrentUserResponseToJson(GetCurrentUserResponse data) =>
    json.encode(data.toJson());

@freezed
class GetCurrentUserResponse with _$GetCurrentUserResponse {
  const factory GetCurrentUserResponse({
    @JsonKey(name: "user") User? user,
  }) = _GetCurrentUserResponse;

  factory GetCurrentUserResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCurrentUserResponseFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: "id") int? id,
    @JsonKey(name: "first_name") String? firstName,
    @JsonKey(name: "last_name") String? lastName,
    @JsonKey(name: "email") String? email,
    @JsonKey(name: "registration_status") String? registrationStatus,
    @JsonKey(name: "picture") Picture? picture,
    @JsonKey(name: "notifications_read") DateTime? notificationsRead,
    @JsonKey(name: "notifications_count") int? notificationsCount,
    @JsonKey(name: "notifications") Notifications? notifications,
    @JsonKey(name: "default_currency") String? defaultCurrency,
    @JsonKey(name: "locale") String? locale,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class Notifications with _$Notifications {
  const factory Notifications({
    @JsonKey(name: "added_as_friend") bool? addedAsFriend,
  }) = _Notifications;

  factory Notifications.fromJson(Map<String, dynamic> json) =>
      _$NotificationsFromJson(json);
}

@freezed
class Picture with _$Picture {
  const factory Picture({
    @JsonKey(name: "small") String? small,
    @JsonKey(name: "medium") String? medium,
    @JsonKey(name: "large") String? large,
  }) = _Picture;

  factory Picture.fromJson(Map<String, dynamic> json) =>
      _$PictureFromJson(json);
}
