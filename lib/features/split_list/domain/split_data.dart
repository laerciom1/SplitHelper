import 'package:split_helper/core/domain/entities/category.dart';
import 'package:split_helper/features/split_list/domain/user_split_data.dart';

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
