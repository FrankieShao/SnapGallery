import 'package:snapgallery/domain/entity/photo/photo.dart';
import 'package:snapgallery/domain/repository/user_repository.dart';

class GetUserPhotos {
  final UserRepository _photoRepository;

  GetUserPhotos(this._photoRepository);

  Future<List<Photo>> call(String userName, int page) {
    return _photoRepository.getPhotos(userName, page);
  }
}
