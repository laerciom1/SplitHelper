// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:split_helper/core/domain/entities/category.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

Settings settingsFromJson(String str) =>
    Settings.fromJson(json.decode(str) as Map<String, dynamic>);

String settingsToJson(Settings data) => json.encode(data.toJson());

@freezed
class Settings with _$Settings {
  const factory Settings({
    @JsonKey(name: "categories") Map<String, Category>? categories,
    @Default(0) @JsonKey(name: "shareConfig") int shareConfig,
    @JsonKey(name: "groups") Map<String, int>? groups,
    @JsonKey(name: "splitUsers") Map<String, int>? splitUsers,
    @JsonKey(name: "selectedGroup") String? selectedGroup,
    @JsonKey(name: "selectedSplitUser") String? selectedSplitUser,
  }) = _Settings;

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);
}
