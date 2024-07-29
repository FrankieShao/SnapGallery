import 'package:injectable/injectable.dart';

import '../entity/collection.dart';
import '../repository/user_repository.dart';

@lazySingleton
class GetUserCollections {
  final UserRepository repository;

  GetUserCollections(this.repository);

  Future<List<Collection>> call(String userName, int page) async {
    return repository.getCollections(userName, page);
  }
}
