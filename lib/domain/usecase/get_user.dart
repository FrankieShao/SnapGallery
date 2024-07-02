import 'package:snapgallery/domain/entity/user/user.dart';
import 'package:snapgallery/domain/repository/user_repository.dart';

class GetUser {
  final UserRepository _userRepository;
  GetUser(this._userRepository);

  Future<User> call(String userName) async {
    if (userName == 'me') return await _userRepository.getMe();
    return await _userRepository.getUser(userName);
  }
}
