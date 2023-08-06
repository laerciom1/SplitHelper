import 'package:split_helper/core/models/settings_data.dart';

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
  final int userId;
  final double paidShare;
  final double owedShare;
  final double balance;

  UserSplitData({
    required this.userId,
    required this.paidShare,
    required this.owedShare,
    required this.balance,
  });
}
