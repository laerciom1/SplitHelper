// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'config.freezed.dart';
part 'config.g.dart';

Config configFromJson(String str) =>
    Config.fromJson(json.decode(str) as Map<String, dynamic>);

String configToJson(Config data) => json.encode(data.toJson());

@freezed
class Config with _$Config {
  const factory Config({
    @JsonKey(name: "consumerKey") String? consumerKey,
    @JsonKey(name: "consumerSecret") String? consumerSecret,
  }) = _Config;

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
}
