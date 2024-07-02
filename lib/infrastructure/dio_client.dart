import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:snapgallery/auth/auth_service.dart';
import 'network_exception.dart';

// This class is responsible for creating a Dio instance and configuring it
class DioClient {
  final AuthService authService;

  late Dio _dio;

  DioClient(this.authService) {
    _dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['BASE_URI']!,
        headers: {
          'Authorization': 'Client-ID ${dotenv.env['ACCESS_KEY']}',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Add interceptors or other configurations
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add any additional request interceptors
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Add any additional response interceptors
        return handler.next(response);
      },
      // Handle errors
      onError: (DioException dioException, handler) {
        final networkException = NetworkExceptions.fromDioError(dioException);
        handler.reject(DioException(
          requestOptions: dioException.requestOptions,
          error: networkException,
        ));
      },
    ));

    // Add pretty logger
    _dio.interceptors.add(PrettyDioLogger());
    authService.addLoginCallback(_updateBearer);
  }

  Dio get dio => _dio;

  void _updateBearer() {
    dio.options.headers.addAll({
      'Authorization': 'Bearer ${authService.getBear()}',
    });
  }
}
