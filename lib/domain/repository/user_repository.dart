import 'package:snapgallery/domain/entity/collection.dart';
import 'package:snapgallery/domain/entity/photo/photo.dart';
import 'package:snapgallery/domain/entity/user/user.dart';
import 'package:snapgallery/domain/gateway/api_service.dart';

abstract class UserRepository {
  Future<User> getMe();
  Future<User> getUser(String userName);
  Future<List<Collection>> getCollections(String userName, int page);
  Future<List<Photo>> getLikes(String userName, int page);
  Future<List<Photo>> getPhotos(String userName, int page);
}

class UserRepositoryImpl implements UserRepository {
  ApiService apiService;

  UserRepositoryImpl(this.apiService);

  @override
  Future<List<Collection>> getCollections(String userName, int page) async {
    return await apiService.getCollections(userName, page);
  }

  @override
  Future<List<Photo>> getLikes(String userName, int page) async {
    return await apiService.getLikes(userName, page);
  }

  @override
  Future<List<Photo>> getPhotos(String userName, int page) async {
    return await apiService.getPhotos(userName, page);
  }

  @override
  Future<User> getUser(String userName) async {
    return await apiService.getUser(userName);
  }

  @override
  Future<User> getMe() async {
    return await apiService.getMe();
  }
}
