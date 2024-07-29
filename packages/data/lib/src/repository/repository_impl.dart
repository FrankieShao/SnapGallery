import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../api/api_service.dart';

@LazySingleton(as: PhotoRepository)
class PhotoRepositoryImpl implements PhotoRepository {
  final ApiService apiService;

  PhotoRepositoryImpl(this.apiService);

  @override
  Future<List<Photo>> getPhotos(String orderBy, int page) async {
    return await apiService.fetchPhotos(orderBy, page);
  }

  @override
  Future<List<Photo>> getTopicPhotos(String topicId, int page) async {
    return await apiService.fetchTopicPhotos(topicId, page);
  }

  @override
  Future<List<Topic>> getTopics() async {
    return await apiService.fetchTopics();
  }

  @override
  Future<List<Photo>> getCollectionPhotos(String collectionId, int page) {
    return apiService.getCollectionPhotos(collectionId, page);
  }
}

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  ApiService apiService;

  UserRepositoryImpl(this.apiService);

  @override
  Future<List<Collection>> getCollections(String userName, int page) async {
    return await apiService.getCollections(userName, page);
  }

  @override
  Future<List<Photo>> getLikes(String userName, int page) async {
    return await apiService.getLikes(userName, page);
  }

  @override
  Future<List<Photo>> getPhotos(String userName, int page) async {
    return await apiService.getPhotos(userName, page);
  }

  @override
  Future<User> getUser(String userName) async {
    return await apiService.getUser(userName);
  }

  @override
  Future<User> getMe() async {
    return await apiService.getMe();
  }
}
