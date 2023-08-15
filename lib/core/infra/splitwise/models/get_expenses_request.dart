// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_expenses_request.freezed.dart';
part 'get_expenses_request.g.dart';

@freezed
class GetExpensesRequest with _$GetExpensesRequest {
  const GetExpensesRequest._();
  const factory GetExpensesRequest({
    required Map<String, dynamic> queryParams,
  }) = _GetExpensesRequest;

  factory GetExpensesRequest.fromJson(Map<String, dynamic> json) =>
      _$GetExpensesRequestFromJson(json);

  String get queryString {
    return queryParams.entries
        .fold('', (accu, curr) => '$accu${curr.key}=${curr.value}');
  }
}
