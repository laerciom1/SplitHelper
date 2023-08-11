import 'package:split_helper/core/models/splitwise_config.dart';
import 'package:split_helper/core/services/config/config_service_firebase_impl.dart';

abstract class IConfigService {
  static SplitWiseConfig? currentSplitWiseConfig;
  Future<SplitWiseConfig> getSplitWiseConfig();

  factory IConfigService() {
    return ConfigServiceFirebase();
  }
}
