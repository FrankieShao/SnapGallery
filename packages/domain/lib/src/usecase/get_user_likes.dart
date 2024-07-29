import 'package:injectable/injectable.dart';

import '../entity/photo/photo.dart';
import '../repository/user_repository.dart';

@lazySingleton
class GetUserLikes {
  final UserRepository _userRepository;

  GetUserLikes(this._userRepository);

  Future<List<Photo>> call(String userName, int page) async {
    return await _userRepository.getLikes(userName, page);
  }
}
