import 'package:snapgallery/domain/entity/collection.dart';
import 'package:snapgallery/domain/repository/user_repository.dart';

class GetUserCollections {
  final UserRepository repository;

  GetUserCollections(this.repository);

  Future<List<Collection>> call(String userName, int page) async {
    return repository.getCollections(userName, page);
  }
}
