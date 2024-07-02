import 'package:dio/dio.dart';
import 'package:snapgallery/domain/entity/collection.dart';
import 'package:snapgallery/domain/entity/user/user.dart';

import '../../../domain/entity/topic.dart';
import '../../../domain/entity/photo/photo.dart';
import '../../../domain/gateway/api_service.dart';

class ApiServiceImpl implements ApiService {
  final Dio client;

  ApiServiceImpl({required this.client});

  @override
  Future<List<Topic>> fetchTopics() async {
    try {
      final response = await client.get('/topics');
      print('fetchTopics >>>> ');
      print(response.data.toString());
      List<dynamic> jsonList = response.data;
      return jsonList.map((json) => Topic.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.error != null) {
        return Future.error(e.error!); // This will throw NetworkExceptions
      } else {
        return Future.error('An error occurred');
      }
    }
  }

  @override
  Future<List<Photo>> fetchPhotos(String orderBy, int page) async {
    try {
      final response = await client.get('/photos', queryParameters: {
        'order_by': orderBy,
        'page': page,
        'per_page': 20,
      });
      print('fetchPhotos $page >>>> ');
      print(response.data.toString());

      List<dynamic> jsonList = response.data;
      return jsonList.map((json) => Photo.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.error != null) {
        return Future.error(e.error!); // This will throw NetworkExceptions
      } else {
        return Future.error('An error occurred');
      }
    }
  }

  @override
  Future<List<Photo>> fetchTopicPhotos(String topicId, int page) async {
    try {
      final response = await client.get('/topics/$topicId/photos',
          queryParameters: {
            'page': page,
            'order_by': 'popular',
            'per_page': 20
          });
      print('fetchTopicPhotos $page >>>> ');
      print(response.data.toString());

      List<dynamic> jsonList = response.data;
      return jsonList.map((json) => Photo.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.error != null) {
        return Future.error(e.error!); // This will throw NetworkExceptions
      } else {
        return Future.error('An error occurred');
      }
    }
  }

  @override
  Future<List<Collection>> getCollections(String userName, int page) async {
    try {
      final response = await client.get('/users/$userName/collections',
          queryParameters: {
            'page': page,
            'username': userName,
            'per_page': 10
          });

      print('getCollections $page >>>> ');
      print(response.data.toString());

      List<dynamic> jsonList = response.data;
      return jsonList.map((json) => Collection.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.error != null) {
        return Future.error(e.error!); // This will throw NetworkExceptions
      } else {
        return Future.error('An error occurred');
      }
    }
  }

  @override
  Future<List<Photo>> getLikes(String userName, int page) async {
    try {
      final response = await client.get('/users/$userName/likes',
          queryParameters: {
            'page': page,
            'username': userName,
            'per_page': 20
          });

      print('getLikes $page >>>> ');
      print(response.data.toString());
      List<dynamic> jsonList = response.data;
      return jsonList.map((json) => Photo.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.error != null) {
        return Future.error(e.error!); // This will throw NetworkExceptions
      } else {
        return Future.error('An error occurred');
      }
    }
  }

  @override
  Future<User> getMe() async {
    try {
      final response = await client.get(
        '/me',
      );
      print('getMe >>>> ');
      print(response.data.toString());
      return User.fromJson(response.data);
    } on DioException catch (e) {
      if (e.error != null) {
        return Future.error(e.error!); // This will throw NetworkExceptions
      } else {
        return Future.error('An error occurred');
      }
    }
  }

  @override
  Future<List<Photo>> getPhotos(String userName, int page) async {
    try {
      final response = await client.get('/users/$userName/photos',
          queryParameters: {
            'page': page,
            'username': userName,
            'per_page': 20
          });

      List<dynamic> jsonList = response.data;
      return jsonList.map((json) => Photo.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.error != null) {
        return Future.error(e.error!); // This will throw NetworkExceptions
      } else {
        return Future.error('An error occurred');
      }
    }
  }

  @override
  Future<User> getUser(String userName) async {
    try {
      final response = await client
          .get('/users/$userName', queryParameters: {'username': userName});
      print('getUser >>>> ');
      print(response.data.toString());
      return User.fromJson(response.data);
    } on DioException catch (e) {
      if (e.error != null) {
        return Future.error(e.error!); // This will throw NetworkExceptions
      } else {
        return Future.error('An error occurred');
      }
    }
  }

  @override
  Future<List<Photo>> getCollectionPhotos(String collectionId, int page) async {
    try {
      final response = await client.get('/collections/$collectionId/photos',
          queryParameters: {'page': page, 'id': collectionId, 'per_page': 20});
      List<dynamic> jsonList = response.data;
      return jsonList.map((json) => Photo.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.error != null) {
        return Future.error(e.error!); // This will throw NetworkExceptions
      } else {
        return Future.error('An error occurred');
      }
    }
  }
}
