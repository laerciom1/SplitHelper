import 'package:dio/dio.dart';
import 'package:oauth2/oauth2.dart';
import 'package:split_helper/core/domain/entities/category.dart' as entity;
import 'package:split_helper/core/domain/entities/settings.dart';
import 'package:split_helper/core/infra/splitwise/models/create_expense_request.dart';
import 'package:split_helper/core/infra/splitwise/models/get_current_user_response.dart';
import 'package:split_helper/core/infra/splitwise/models/get_expenses_response.dart';
import 'package:split_helper/core/infra/storage.dart';
import 'package:split_helper/features/split_list/domain/user_split_data.dart';

const baseUrl = 'https://secure.splitwise.com/api/v3.0';

enum Endpoints {
  getCurrentUser('/get_current_user'),
  getExpenses('/get_expenses'),
  createExpense('/create_expense');

  const Endpoints(this.value);
  final String value;
}

class SplitwiseRepository {
  final Dio _dio;
  final SecureStorage _storage;

  SplitwiseRepository(this._dio, this._storage) {
    initializeDio();
  }

  Future<void> initializeDio() async {
    final credentialsJson =
        await _storage.read(SecureStorage.authCredentialsKey);
    final credentials = Credentials.fromJson(credentialsJson!);
    _dio.options = BaseOptions(
      headers: {'Authorization': 'Bearer ${credentials.accessToken}'},
    );
  }

  Future<GetCurrentUserResponse> getCurrentUser() async {
    final response =
        await _dio.get('$baseUrl${Endpoints.getCurrentUser.value}');
    return GetCurrentUserResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<List<Expense>> getExpenses(int groupId) async {
    final response = await _dio.get(
      '$baseUrl${Endpoints.getExpenses.value}',
      queryParameters: {
        'group_id': groupId,
      },
    );
    final getExpensesResponse =
        GetExpensesResponse.fromJson(response.data as Map<String, dynamic>);
    return getExpensesResponse.expenses!;
  }

  Future<void> addSplit({
    required double cost,
    required String description,
    required entity.Category category,
    required int shareConfig,
    required Settings settings,
    required int currentUserId,
    required int groupId,
    required List<UserSplitData> shares,
  }) async {
    final data = CreateExpenseRequest(
      cost: cost.toStringAsFixed(2),
      description: '${category.prefix} $description',
      date: DateTime.now(),
      categoryId: int.parse(category.id!),
      groupId: groupId,
      users0UserId: shares[0].userId,
      users0PaidShare: shares[0].paidShare.toStringAsFixed(2),
      users0OwedShare: shares[0].owedShare.toStringAsFixed(2),
      users1UserId: shares[1].userId,
      users1PaidShare: shares[1].paidShare.toStringAsFixed(2),
      users1OwedShare: shares[1].owedShare.toStringAsFixed(2),
    ).toJson();
    await _dio.post(
      '$baseUrl${Endpoints.createExpense.value}',
      data: data,
    );
    return;
  }
}
