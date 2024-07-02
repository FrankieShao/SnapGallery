import 'package:snapgallery/domain/entity/photo/photo.dart';
import 'package:snapgallery/domain/repository/user_repository.dart';

class GetUserLikes {
  final UserRepository _userRepository;

  GetUserLikes(this._userRepository);

  Future<List<Photo>> call(String userName, int page) async {
    return await _userRepository.getLikes(userName, page);
  }
}
