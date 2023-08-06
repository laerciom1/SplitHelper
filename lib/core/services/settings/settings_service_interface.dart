import 'package:split_helper/core/models/settings_data.dart';
import 'package:split_helper/core/services/settings/settings_service_mock_impl.dart';

abstract class ISettingsService {
  Future<Settings> update({
    required Settings settings,
  });

  Stream<Settings> get();

  factory ISettingsService() {
    return SettingsServiceMock();
  }
}
