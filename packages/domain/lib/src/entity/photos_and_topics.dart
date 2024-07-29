import 'package:equatable/equatable.dart';
import 'topic.dart';
import 'photo/photo.dart';

final class PhotosAndTopics extends Equatable {
  final List<Photo> photos;
  final List<Topic> topics;
  final int page;

  const PhotosAndTopics(
      {required this.photos, required this.topics, required this.page});

  PhotosAndTopics copyWith({required List<Photo> photos, required int page}) {
    return PhotosAndTopics(
        photos: photos, topics: this.topics, page: this.page);
  }

  @override
  List<Object> get props => [photos, topics];
}
