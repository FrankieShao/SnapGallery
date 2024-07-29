// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/src/repository/photo_repository.dart' as _i495;
import 'package:domain/src/repository/user_repository.dart' as _i868;
import 'package:domain/src/usecase/get_collection_photos.dart' as _i161;
import 'package:domain/src/usecase/get_photos.dart' as _i570;
import 'package:domain/src/usecase/get_topic_photos.dart' as _i593;
import 'package:domain/src/usecase/get_topics.dart' as _i718;
import 'package:domain/src/usecase/get_user.dart' as _i644;
import 'package:domain/src/usecase/get_user_collections.dart' as _i598;
import 'package:domain/src/usecase/get_user_likes.dart' as _i492;
import 'package:domain/src/usecase/get_user_photos.dart' as _i62;
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
    gh.lazySingleton<_i593.GetTopicPhotos>(
        () => _i593.GetTopicPhotos(gh<_i495.PhotoRepository>()));
    gh.lazySingleton<_i570.GetPhotos>(
        () => _i570.GetPhotos(gh<_i495.PhotoRepository>()));
    gh.lazySingleton<_i161.GetCollectionPhotos>(
        () => _i161.GetCollectionPhotos(gh<_i495.PhotoRepository>()));
    gh.lazySingleton<_i718.GetTopics>(
        () => _i718.GetTopics(gh<_i495.PhotoRepository>()));
    gh.lazySingleton<_i62.GetUserPhotos>(
        () => _i62.GetUserPhotos(gh<_i868.UserRepository>()));
    gh.lazySingleton<_i598.GetUserCollections>(
        () => _i598.GetUserCollections(gh<_i868.UserRepository>()));
    gh.lazySingleton<_i492.GetUserLikes>(
        () => _i492.GetUserLikes(gh<_i868.UserRepository>()));
    gh.lazySingleton<_i644.GetUser>(
        () => _i644.GetUser(gh<_i868.UserRepository>()));
    return this;
  }
}
