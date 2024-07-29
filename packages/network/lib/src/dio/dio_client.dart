import 'package:common/common.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:network/src/dio/auth_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'exception_interceptor.dart';

// This class is responsible for creating a Dio instance and configuring it
// Dio Factory
class DioBuilder {
  const DioBuilder._();

  static Dio createDio({
    required AuthService authService,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: BuildConfig.baseUrl,
        headers: {
          'Authorization': 'Client-ID ${BuildConfig.accessKey}',
          'Content-Type': 'application/json',
        },
      ),
    );
    dio.interceptors.add(AuthInterceptor(authService));
    dio.interceptors.add(ExceptionInterceptor());
    if (BuildConfig.showNetworkLogs) {
      dio.interceptors.add(PrettyDioLogger());
    }
    return dio;
  }
}
