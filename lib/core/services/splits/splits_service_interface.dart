import 'package:split_helper/core/models/split_data.dart';
import 'package:split_helper/core/services/splits/splits_service_mock_impl.dart';

abstract class ISplitsService {
  /*
    {
      "cost": "100",
      "description": "TEST",
      "group_id": 001122,
      "date": "2023-08-02T15:00:00Z",
      "currency_code": "BRL",
      "category_id": 13,
      "users__0__user_id": 123,
      "users__0__paid_share": "100",
      "users__0__owed_share": "85",
      "users__1__user_id": 321,
      "users__1__paid_share": "0",
      "users__1__owed_share": "15"
    }
  */
  Future<SplitData> save({
    required double cost,
    required String description,
    required int categoryId,
    required int groupId, // Firebase
    required List<UserSplitData> shares, // Id do Firebase e Valores do Input
    // DateTime date, // NOW
    // String currencyCode, // BRL
  });

  Stream<List<SplitData>> getSplits();

  Future<void> updateSplits();

  factory ISplitsService() {
    return SplitsServiceMock();
  }
}
