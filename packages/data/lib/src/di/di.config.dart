// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:data/data.dart' as _i437;
import 'package:data/src/api/api_service.dart' as _i59;
import 'package:data/src/repository/repository_impl.dart' as _i1013;
import 'package:domain/domain.dart' as _i494;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

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
    gh.lazySingleton<_i59.ApiService>(
        () => _i59.ApiServiceImpl(gh<_i437.HttpService>()));
    gh.lazySingleton<_i494.UserRepository>(
        () => _i1013.UserRepositoryImpl(gh<_i59.ApiService>()));
    gh.lazySingleton<_i494.PhotoRepository>(
        () => _i1013.PhotoRepositoryImpl(gh<_i59.ApiService>()));
    return this;
  }
}
