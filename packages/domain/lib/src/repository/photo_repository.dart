import '../entity/photo/photo.dart';
import '../entity/topic.dart';

abstract class PhotoRepository {
  Future<List<Topic>> getTopics();
  Future<List<Photo>> getPhotos(String orderBy, int page);
  Future<List<Photo>> getTopicPhotos(String topicId, int page);
  Future<List<Photo>> getCollectionPhotos(String collectionId, int page);
}
