import 'package:split_helper/core/domain/entities/category.dart' as entity;
import 'package:split_helper/core/infra/splitwise/models/get_expenses_response.dart';
import 'package:split_helper/features/split_list/domain/user_split_data.dart';

class SplitData {
  late int id;
  late String description;
  late String cost;
  late DateTime date;
  late List<UserSplitData> users;
  late entity.Category? category;

  SplitData({
    required this.id,
    required this.description,
    required this.cost,
    required this.date,
    required this.users,
    required this.category,
  });

  SplitData.fromExpense({
    required Expense expense,
    required String imageUrl,
    required String prefix,
  }) {
    id = expense.id!;
    description = expense.description!;
    cost = expense.cost!;
    date = expense.date!;
    users = expense.users!
        .map(
          (elem) => UserSplitData(
            owedShare: double.parse(elem.owedShare!),
            userId: elem.userId,
            paidShare: double.parse(elem.paidShare!),
            balance: double.parse(elem.netBalance!),
          ),
        )
        .toList();
    category = entity.Category(
      prefix: prefix,
      imageUrl: imageUrl,
    );
  }
}
