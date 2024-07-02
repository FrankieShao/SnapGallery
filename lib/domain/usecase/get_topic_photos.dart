import '../repository/photo_repository.dart';
import '../entity/photo/photo.dart';

class GetTopicPhotos {
  final PhotoRepository _photoRepository;

  GetTopicPhotos(this._photoRepository);

  Future<List<Photo>> call(String topicId, int page) async {
    return await _photoRepository.getTopicPhotos(topicId, page);
  }
}