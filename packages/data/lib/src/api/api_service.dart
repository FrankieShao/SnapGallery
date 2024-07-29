import 'package:common/common.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../data.dart';
import 'api_service_impl.dart';
import 'fake_api_service.dart';

abstract class ApiService {
  Future<List<Topic>> fetchTopics();
  Future<List<Photo>> fetchPhotos(String orderBy, int page);
  Future<List<Photo>> fetchTopicPhotos(String topicId, int page);
  Future<List<Photo>> getCollectionPhotos(String collectionId, int page);
  Future<User> getMe();
  Future<User> getUser(String userName);
  Future<List<Collection>> getCollections(String userName, int page);
  Future<List<Photo>> getLikes(String userName, int page);
  Future<List<Photo>> getPhotos(String userName, int page);
}

@LazySingleton(as: ApiService)
class ApiServiceImpl extends ApiService {
  final HttpService httpService;
  final ApiService _apiDelegate;

  ApiServiceImpl(this.httpService)
      : _apiDelegate = BuildConfig.isMockData
            ? FakeApiService()
            : RealApiService(httpService);

  @override
  Future<List<Photo>> fetchPhotos(String orderBy, int page) {
    return _apiDelegate.fetchPhotos(orderBy, page);
  }

  @override
  Future<List<Photo>> fetchTopicPhotos(String topicId, int page) {
    return _apiDelegate.fetchTopicPhotos(topicId, page);
  }

  @override
  Future<List<Topic>> fetchTopics() {
    return _apiDelegate.fetchTopics();
  }

  @override
  Future<List<Photo>> getCollectionPhotos(String collectionId, int page) {
    return _apiDelegate.getCollectionPhotos(collectionId, page);
  }

  @override
  Future<List<Collection>> getCollections(String userName, int page) {
    return _apiDelegate.getCollections(userName, page);
  }

  @override
  Future<List<Photo>> getLikes(String userName, int page) {
    return _apiDelegate.getLikes(userName, page);
  }

  @override
  Future<User> getMe() {
    return _apiDelegate.getMe();
  }

  @override
  Future<List<Photo>> getPhotos(String userName, int page) {
    return _apiDelegate.getPhotos(userName, page);
  }

  @override
  Future<User> getUser(String userName) {
    return _apiDelegate.getUser(userName);
  }
}
