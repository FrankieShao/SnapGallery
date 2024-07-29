import 'package:common/common.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:network/framework.dart';

abstract class ApplicationConfig extends Config {}

class AppInitializer {
  AppInitializer(this._applicationConfig);

  final ApplicationConfig _applicationConfig;

  Future<void> init() async {
    await DataConfig.getInstance().init();
    await DomainConfig.getInstance().init();
    await NetworkConfig.getInstance().init();
    await CommonConfig.getInstance().init();
    await _applicationConfig.init();
  }
}
