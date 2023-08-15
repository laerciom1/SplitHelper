// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

Category categoryFromJson(String str) =>
    Category.fromJson(json.decode(str) as Map<String, dynamic>);

String categoryToJson(Category data) => json.encode(data.toJson());

@freezed
class Category with _$Category {
  const factory Category({
    @JsonKey(name: "id") String? id,
    @JsonKey(name: "prefix") String? prefix,
    @JsonKey(name: "imageUrl") String? imageUrl,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
