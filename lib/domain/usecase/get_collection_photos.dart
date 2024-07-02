import 'package:snapgallery/domain/entity/photo/photo.dart';
import 'package:snapgallery/domain/repository/photo_repository.dart';

class GetCollectionPhotos {
  final PhotoRepository repository;

  GetCollectionPhotos(this.repository);

  Future<List<Photo>> call(String collectionId, int page) async {
    return await repository.getCollectionPhotos(collectionId, page);
  }
}
