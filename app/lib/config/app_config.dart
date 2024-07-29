import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:initializer/initializer.dart';
import '../di/di.dart' as di;
import '../base/bloc/app_bloc_observer.dart';

class AppConfig extends ApplicationConfig {
  factory AppConfig.getInstance() {
    return _instance;
  }

  AppConfig._();

  static final AppConfig _instance = AppConfig._();

  @override
  Future<void> config() async {
    di.configureDependencies();
    Bloc.observer = AppBlocObserver();
  }
}
