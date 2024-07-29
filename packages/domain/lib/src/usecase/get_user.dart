import 'package:injectable/injectable.dart';

import '../entity/user/user.dart';
import '../repository/user_repository.dart';

@lazySingleton
class GetUser {
  final UserRepository _userRepository;
  GetUser(this._userRepository);

  Future<User> call(String userName) async {
    if (userName == 'me') return await _userRepository.getMe();
    return await _userRepository.getUser(userName);
  }
}
