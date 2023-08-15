import 'package:dio/dio.dart';
import 'package:oauth2/oauth2.dart';
import 'package:split_helper/core/infra/splitwise/models/get_current_user_response.dart';
import 'package:split_helper/core/infra/splitwise/models/get_expenses_response.dart';
import 'package:split_helper/core/infra/storage.dart';

const baseUrl = 'https://secure.splitwise.com/api/v3.0';

enum Endpoints {
  getCurrentUser('/get_current_user'),
  getExpenses('/get_expenses');

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
    print('getExpenses');
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
}
