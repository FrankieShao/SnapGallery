import 'package:dio/dio.dart';
import 'package:network/src/dio/network_exception.dart';

class ExceptionInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final networkException = NetworkExceptions.fromDioError(err);
    handler.reject(DioException(
      requestOptions: err.requestOptions,
      error: networkException,
    ));
  }
}
