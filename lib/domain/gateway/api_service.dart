import 'package:snapgallery/domain/entity/collection.dart';
import 'package:snapgallery/domain/entity/photo/photo.dart';
import 'package:snapgallery/domain/entity/topic.dart';
import 'package:snapgallery/domain/entity/user/user.dart';

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
