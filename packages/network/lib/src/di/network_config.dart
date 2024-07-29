import 'package:common/common.dart';
import 'di.dart' as di;

class NetworkConfig extends Config {
  factory NetworkConfig.getInstance() {
    return _instance;
  }

  NetworkConfig._();

  static final NetworkConfig _instance = NetworkConfig._();

  @override
  Future<void> config() async => di.configureInjection();
}
