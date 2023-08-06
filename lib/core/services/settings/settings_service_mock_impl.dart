import 'dart:async';
import 'package:split_helper/core/models/settings_data.dart';
import 'package:split_helper/core/services/settings/settings_mock.dart';
import 'package:split_helper/core/services/settings/settings_service_interface.dart';

class SettingsServiceMock implements ISettingsService {
  static Settings _settings = Settings.fromJson(mockedSettings);
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
    _settings = settings;
    _controller?.add(_settings);
    return _settings;
  }
}
