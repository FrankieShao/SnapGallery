// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:data/data.dart' as _i437;
import 'package:domain/domain.dart' as _i494;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:network/src/dio/auth_interceptor.dart' as _i477;
import 'package:network/src/dio/http_service_impl.dart' as _i438;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i437.HttpService>(
        () => _i438.HttpServiceImpl(authService: gh<_i494.AuthService>()));
    gh.factory<_i477.AuthInterceptor>(
        () => _i477.AuthInterceptor(gh<_i494.AuthService>()));
    return this;
  }
}
