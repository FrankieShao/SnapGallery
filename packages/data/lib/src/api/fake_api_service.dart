import 'dart:convert';
import 'package:domain/domain.dart';
import 'package:flutter/services.dart';

import 'api_service.dart';

class FakeApiService extends ApiService {
  FakeApiService();

  @override
  Future<List<Photo>> fetchPhotos(String orderBy, int page) async {
    try {
      String fileName = 'mock_data/photo1.json';
      switch (page) {
        case 1:
          fileName = 'mock_data/photo1.json';
        case 2:
          fileName = 'mock_data/photo2.json';
        default:
          fileName = 'mock_data/photo3.json';
      }
      String jsonString = await loadJsonData(fileName);
      List<dynamic> jsonResponse = json.decode(jsonString);
      return jsonResponse.map((data) => Photo.fromJson(data)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<List<Photo>> fetchTopicPhotos(String topicId, int page) async {
    try {
      String fileName = 'mock_data/photo1.json';
      switch (page) {
        case 1:
          fileName = 'mock_data/photo1.json';
        case 2:
          fileName = 'mock_data/photo2.json';
        default:
          fileName = 'mock_data/photo3.json';
      }
      String jsonString = await loadJsonData(fileName);
      List<dynamic> jsonResponse = json.decode(jsonString);
      return jsonResponse.map((data) => Photo.fromJson(data)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<List<Topic>> fetchTopics() async {
    try {
      String fileName = 'mock_data/topics.json';
      String jsonString = await loadJsonData(fileName);
      List<dynamic> jsonResponse = json.decode(jsonString);
      return jsonResponse.map((data) => Topic.fromJson(data)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<List<Photo>> getCollectionPhotos(String collectionId, int page) async {
    String fileName = 'mock_data/photo1.json';
    switch (page) {
      case 1:
        fileName = 'mock_data/photo1.json';
      case 2:
        fileName = 'mock_data/photo2.json';
      default:
        fileName = 'mock_data/photo3.json';
    }
    String jsonString = await loadJsonData(fileName);
    List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((data) => Photo.fromJson(data)).toList();
  }

  @override
  Future<List<Collection>> getCollections(String userName, int page) async {
    String fileName = 'mock_data/collections1.json';
    switch (page) {
      case 1:
        fileName = 'mock_data/collections1.json';
      default:
        fileName = 'mock_data/collections2.json';
    }
    String jsonString = await loadJsonData(fileName);
    List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((data) => Collection.fromJson(data)).toList();
  }

  @override
  Future<List<Photo>> getLikes(String userName, int page) async {
    String fileName = 'mock_data/photo1.json';
    switch (page) {
      case 1:
        fileName = 'mock_data/photo1.json';
      case 2:
        fileName = 'mock_data/photo2.json';
      default:
        fileName = 'mock_data/photo3.json';
    }
    String jsonString = await loadJsonData(fileName);
    List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((data) => Photo.fromJson(data)).toList();
  }

  @override
  Future<User> getMe() async {
    Map<String, dynamic> j =
        json.decode(await loadJsonData('mock_data/user.json'));
    return User.fromJson(j);
  }

  @override
  Future<List<Photo>> getPhotos(String userName, int page) async {
    String fileName = 'mock_data/photo1.json';
    switch (page) {
      case 1:
        fileName = 'mock_data/photo1.json';
      case 2:
        fileName = 'mock_data/photo2.json';
      default:
        fileName = 'mock_data/photo3.json';
    }
    String jsonString = await loadJsonData(fileName);
    List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((data) => Photo.fromJson(data)).toList();
  }

  @override
  Future<User> getUser(String userName) async {
    Map<String, dynamic> j =
        json.decode(await loadJsonData('mock_data/user.json'));
    return User.fromJson(j);
  }

  Future<String> loadJsonData(String path) async {
    return await rootBundle.loadString('packages/data/$path');
  }
}
