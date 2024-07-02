import '../repository/photo_repository.dart';
import '../entity/photo/photo.dart';

class GetPhotos {
  final PhotoRepository _photoRepository;

  GetPhotos(this._photoRepository);

  Future<List<Photo>> call(String orderBy, int page) async {
    return await _photoRepository.getPhotos(orderBy, page);
  }
}