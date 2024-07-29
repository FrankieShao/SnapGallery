import 'package:dio/dio.dart';

// NetworkException class to handle network exceptions
class NetworkExceptions implements Exception {
  late String message;

  NetworkExceptions([String? message]) {
    this.message = message ?? 'Unknown error occurred';
  }

  factory NetworkExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return NetworkExceptions('Request to API server was cancelled');
      case DioExceptionType.connectionTimeout:
        return NetworkExceptions('Connection timeout with API server');
      case DioExceptionType.receiveTimeout:
        return NetworkExceptions(
            'Receive timeout in connection with API server');
      case DioExceptionType.badResponse:
        return NetworkExceptions.fromResponse(
            dioError.response!.statusCode, dioError.response!.data);
      case DioExceptionType.sendTimeout:
        return NetworkExceptions('Send timeout in connection with API server');
      case DioExceptionType.unknown:
        return NetworkExceptions(
            'Connection to API server failed due to internet connection');
      default:
        return NetworkExceptions('Unexpected error occurred');
    }
  }

  factory NetworkExceptions.fromResponse(int? statusCode, dynamic response) {
    switch (statusCode) {
      case 400:
        return NetworkExceptions('Bad request');
      case 401:
        return NetworkExceptions('Unauthorized');
      case 403:
        return NetworkExceptions('Forbidden');
      case 404:
        return NetworkExceptions('Not found');
      case 500:
        return NetworkExceptions('Internal server error');
      default:
        return NetworkExceptions('Received invalid status code: $statusCode');
    }
  }

  @override
  String toString() => message;
}
