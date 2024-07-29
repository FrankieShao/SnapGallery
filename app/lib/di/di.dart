import 'package:domain/domain.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:app/auth/auth_service.dart';
import 'package:app/ui/main/bloc/photo_list_bloc.dart';
import 'package:app/ui/main/bloc/topic_photo_bloc.dart';
import 'package:app/ui/menu/bloc/user_collection_bloc.dart';
import 'package:app/ui/user_detail/bloc/user_likes_bloc.dart';
import 'package:app/ui/main/cubit/topics_cubit.dart';
import 'package:app/ui/menu/cubit/user_profile_cubit.dart';

final GetIt DI = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  DI.registerLazySingleton<ZoomDrawerController>(() => ZoomDrawerController());
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
  DI.registerLazySingleton<AuthService>(() => AuthServiceImpl());
}
