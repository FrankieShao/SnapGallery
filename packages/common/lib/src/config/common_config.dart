import 'config.dart';

class CommonConfig extends Config {
  CommonConfig._();

  factory CommonConfig.getInstance() {
    return _instance;
  }

  static final CommonConfig _instance = CommonConfig._();

  @override
  Future<void> config() async {
    // dotenv.load(fileName: ".env");
  }
}
