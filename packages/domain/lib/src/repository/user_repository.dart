import '../entity/collection.dart';
import '../entity/photo/photo.dart';
import '../entity/user/user.dart';

abstract class UserRepository {
  Future<User> getMe();
  Future<User> getUser(String userName);
  Future<List<Collection>> getCollections(String userName, int page);
  Future<List<Photo>> getLikes(String userName, int page);
  Future<List<Photo>> getPhotos(String userName, int page);
}
