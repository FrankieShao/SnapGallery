import '../entity/photo/photo.dart';
import '../entity/topic.dart';
import '../gateway/api_service.dart';

abstract class PhotoRepository {
  Future<List<Topic>> getTopics();
  Future<List<Photo>> getPhotos(String orderBy, int page);
  Future<List<Photo>> getTopicPhotos(String topicId, int page);
  Future<List<Photo>> getCollectionPhotos(String collectionId, int page);
}

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
