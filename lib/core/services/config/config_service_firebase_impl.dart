import 'package:firebase_database/firebase_database.dart';
import 'package:split_helper/core/models/splitwise_config.dart';
import 'package:split_helper/core/services/config/config_service_interface.dart';

class ConfigServiceFirebase implements IConfigService {
  @override
  Future<SplitWiseConfig> getSplitWiseConfig() async {
    final ref = FirebaseDatabase.instance.ref();
    final value = (await ref.child('_splitwiseConfig').get()).value! as Map;
    IConfigService.currentSplitWiseConfig = SplitWiseConfig(
      key: value['consumerKey'],
      secret: value['consumerSecret'],
    );
    return IConfigService.currentSplitWiseConfig!;
  }
}
