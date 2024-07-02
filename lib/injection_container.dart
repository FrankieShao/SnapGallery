import 'package:dio/dio.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:snapgallery/auth/auth_service.dart';
import 'package:snapgallery/config.dart';
import 'package:snapgallery/data/dataresource/remote/fake_api_service.dart';
import 'package:snapgallery/domain/repository/user_repository.dart';
import 'package:snapgallery/domain/usecase/get_collection_photos.dart';
import 'package:snapgallery/domain/usecase/get_user.dart';
import 'package:snapgallery/domain/usecase/get_user_collections.dart';
import 'package:snapgallery/domain/usecase/get_user_likes.dart';
import 'package:snapgallery/domain/usecase/get_user_photos.dart';
import 'package:snapgallery/presentation/bloc/photo_list_bloc.dart';
import 'package:snapgallery/presentation/bloc/topic_photo_bloc.dart';
import 'package:snapgallery/presentation/bloc/user_collection_bloc.dart';
import 'package:snapgallery/presentation/bloc/user_likes_bloc.dart';
import 'package:snapgallery/presentation/cubit/topics_cubit.dart';
import 'package:snapgallery/presentation/cubit/user_profile_cubit.dart';
import 'domain/usecase/get_topic_photos.dart';
import 'infrastructure/dio_client.dart';
import 'domain/gateway/api_service.dart';
import 'domain/repository/photo_repository.dart';
import 'domain/usecase/get_topics.dart';
import 'domain/usecase/get_photos.dart';
import 'data/dataresource/remote/api_service_impl.dart';

final GetIt DI = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  DI.registerFactory(() => TopicsCubit(DI()));

  DI.registerFactoryParam<MainPhotoListBloc, String, void>(
      (order, _) => MainPhotoListBloc(orderBy: order, getPhotos: DI()));
  DI.registerFactoryParam<TopicPhotoBloc, String, void>(
      (slug, _) => TopicPhotoBloc(topicSlug: slug, getTopicPhotos: DI()));

  DI.registerFactoryParam<UserProfileCubit, String, void>((name, _) =>
      UserProfileCubit(userName: name, getUser: DI(), authService: DI()));
  DI.registerFactoryParam<UserLikesBloc, String, void>(
      (name, _) => UserLikesBloc(userName: name, getUserLikes: DI()));

  DI.registerFactoryParam<CollectionsBloc, String, void>((name, _) =>
      CollectionsBloc(
          userName: name, getCollectionPhotos: DI(), getUserCollections: DI()));

  DI.registerLazySingleton(() => GetTopics(DI()));
  DI.registerLazySingleton(() => GetPhotos(DI()));
  DI.registerLazySingleton(() => GetTopicPhotos(DI()));

  DI.registerLazySingleton(() => GetUser(DI()));
  DI.registerLazySingleton(() => GetUserCollections(DI()));
  DI.registerLazySingleton(() => GetUserLikes(DI()));
  DI.registerLazySingleton(() => GetUserPhotos(DI()));
  DI.registerLazySingleton(() => GetCollectionPhotos(DI()));

  DI.registerLazySingleton<ZoomDrawerController>(() => ZoomDrawerController());
  DI.registerLazySingleton<PhotoRepository>(() => PhotoRepositoryImpl(DI()));
  DI.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(DI()));

  DI.registerLazySingleton<AuthService>(() => AuthServiceImpl());
  DI.registerLazySingleton<TokenInjector>(() => TokenInjectorImpl(DI()));
  DI.registerLazySingleton<Dio>(() => DioClient(DI()).dio);
  if (Config.isMockData) {
    DI.registerLazySingleton<ApiService>(() => FakeApiService(client: DI()));
  } else {
    DI.registerLazySingleton<ApiService>(() => ApiServiceImpl(client: DI()));
  }
}
