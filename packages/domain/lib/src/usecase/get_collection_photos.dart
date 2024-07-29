import 'package:injectable/injectable.dart';

import '../entity/photo/photo.dart';
import '../repository/photo_repository.dart';

@lazySingleton
class GetCollectionPhotos {
  final PhotoRepository repository;

  GetCollectionPhotos(this.repository);

  Future<List<Photo>> call(String collectionId, int page) async {
    return await repository.getCollectionPhotos(collectionId, page);
  }
}
