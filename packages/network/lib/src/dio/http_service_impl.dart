import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:network/src/dio/dio_client.dart';
import 'network_exception.dart';

@LazySingleton(as: HttpService)
class HttpServiceImpl implements HttpService {
  final Dio _dio;

  HttpServiceImpl({
    required AuthService authService,
  }) : _dio = DioBuilder.createDio(authService: authService);

  @override
  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters}) {
    try {
      return _dio.get(url, queryParameters: queryParameters).then((response) {
        return response.data;
      });
    } on DioException catch (e) {
      if (e.error is NetworkExceptions) {
        final networkE = e.error as NetworkExceptions;
        throw Exception(networkE.message);
      } else {
        throw Exception(e);
      }
    }
  }

  @override
  Future<dynamic> post(String url,
      {Map<String, dynamic>? data, Map<String, dynamic>? queryParameters}) {
    try {
      return _dio
          .post(url, data: data, queryParameters: queryParameters)
          .then((response) {
        return response.data;
      });
    } on DioException catch (e) {
      if (e.error is NetworkExceptions) {
        final networkE = e.error as NetworkExceptions;
        throw Exception(networkE.message);
      } else {
        throw Exception(e);
      }
    }
  }
}
