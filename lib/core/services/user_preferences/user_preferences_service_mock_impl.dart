import 'dart:async';
import 'package:split_helper/core/models/settings_data.dart';
import 'package:split_helper/core/services/user_preferences/user_preferences_mock.dart';
import 'package:split_helper/core/services/user_preferences/user_preferences_service_interface.dart';

const duration = Duration(seconds: 2);

class UserPreferencesServiceMock implements IUserPreferencesService {
  static Settings _settings = Settings.fromJson(mockedUserPreferences);
  static MultiStreamController<Settings>? _controller;
  static final _settingsStream = Stream<Settings>.multi((controller) {
    _controller = controller;
    controller.add(_settings);
  });

  @override
  Stream<Settings> get() {
    return _settingsStream;
  }

  @override
  Future<Settings> update({required Settings settings}) async {
    return Future.delayed(duration, () {
      _settings = settings;
      _controller?.add(_settings);
      return _settings;
    });
  }
}
