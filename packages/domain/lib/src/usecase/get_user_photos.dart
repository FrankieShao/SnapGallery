import 'package:injectable/injectable.dart';

import '../entity/photo/photo.dart';
import '../repository/user_repository.dart';

@lazySingleton
class GetUserPhotos {
  final UserRepository _photoRepository;

  GetUserPhotos(this._photoRepository);

  Future<List<Photo>> call(String userName, int page) {
    return _photoRepository.getPhotos(userName, page);
  }
}
