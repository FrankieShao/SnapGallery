import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AuthInterceptor extends InterceptorsWrapper {
  final AuthService authService;

  AuthInterceptor(this.authService) {
    authService.addLoginCallback(_updateBearer);
  }

  final Map<String, dynamic> _headers = {};

  void _updateBearer() {
    _headers.addAll({
      'Authorization': 'Bearer ${authService.getBear()}',
    });
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll(_headers);
    handler.next(options);
  }
}
