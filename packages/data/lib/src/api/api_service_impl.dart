import 'package:data/src/api/http_service.dart';
import 'package:domain/domain.dart';

import 'api_service.dart';

class RealApiService implements ApiService {
  final HttpService httpService;

  RealApiService(this.httpService);

  @override
  Future<List<Topic>> fetchTopics() async {
    try {
      final response = await httpService.get('/topics');
      List<dynamic> jsonList = response;
      return jsonList.map((json) => Topic.fromJson(json)).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<Photo>> fetchPhotos(String orderBy, int page) async {
    try {
      final response = await httpService.get('/photos', queryParameters: {
        'order_by': orderBy,
        'page': page,
        'per_page': 20,
      });
      List<dynamic> jsonList = response;
      return jsonList.map((json) => Photo.fromJson(json)).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<Photo>> fetchTopicPhotos(String topicId, int page) async {
    try {
      final response = await httpService.get('/topics/$topicId/photos',
          queryParameters: {
            'page': page,
            'order_by': 'popular',
            'per_page': 20
          });
      List<dynamic> jsonList = response;
      return jsonList.map((json) => Photo.fromJson(json)).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<Collection>> getCollections(String userName, int page) async {
    try {
      final response = await httpService.get('/users/$userName/collections',
          queryParameters: {
            'page': page,
            'username': userName,
            'per_page': 10
          });

      List<dynamic> jsonList = response;
      return jsonList.map((json) => Collection.fromJson(json)).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<Photo>> getLikes(String userName, int page) async {
    try {
      final response = await httpService.get('/users/$userName/likes',
          queryParameters: {
            'page': page,
            'username': userName,
            'per_page': 20
          });

      List<dynamic> jsonList = response;
      return jsonList.map((json) => Photo.fromJson(json)).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<User> getMe() async {
    try {
      final response = await httpService.get(
        '/me',
      );
      return User.fromJson(response);
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<Photo>> getPhotos(String userName, int page) async {
    try {
      final response = await httpService.get('/users/$userName/photos',
          queryParameters: {
            'page': page,
            'username': userName,
            'per_page': 20
          });

      List<dynamic> jsonList = response;
      return jsonList.map((json) => Photo.fromJson(json)).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<User> getUser(String userName) async {
    try {
      final response = await httpService
          .get('/users/$userName', queryParameters: {'username': userName});
      return User.fromJson(response);
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<Photo>> getCollectionPhotos(String collectionId, int page) async {
    try {
      final response = await httpService.get(
          '/collections/$collectionId/photos',
          queryParameters: {'page': page, 'id': collectionId, 'per_page': 20});
      List<dynamic> jsonList = response;
      return jsonList.map((json) => Photo.fromJson(json)).toList();
    } catch (e) {
      return Future.error(e);
    }
  }
}
