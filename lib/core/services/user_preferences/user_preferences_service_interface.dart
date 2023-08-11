import 'package:split_helper/core/models/settings_data.dart';
import 'package:split_helper/core/services/user_preferences/user_preferences_service_mock_impl.dart';

abstract class IUserPreferencesService {
  Future<Settings> update({
    required Settings settings,
  });

  Stream<Settings> get();

  factory IUserPreferencesService() {
    return UserPreferencesServiceMock();
  }
}
