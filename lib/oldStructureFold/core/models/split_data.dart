import 'package:split_helper/oldStructureFold/core/models/settings_data.dart';

class SplitData {
  final int id;
  final String description;
  final String cost;
  final String date;
  final List<UserSplitData> users;
  Category? category;

  SplitData({
    required this.id,
    required this.description,
    required this.cost,
    required this.date,
    required this.users,
    required this.category,
  });
}

class UserSplitData {
  final double owedShare;
  int? userId;
  double? paidShare;
  double? balance;

  UserSplitData({
    required this.owedShare,
    this.userId,
    this.paidShare,
    this.balance,
  });
}
