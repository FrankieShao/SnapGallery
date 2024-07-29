import 'package:injectable/injectable.dart';

import '../entity/topic.dart';
import '../repository/photo_repository.dart';

@lazySingleton
class GetTopics {
  final PhotoRepository repository;

  GetTopics(this.repository);

  Future<List<Topic>> call() async {
    return await repository.getTopics();
  }
}
