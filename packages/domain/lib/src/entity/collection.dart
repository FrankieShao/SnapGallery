import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'user/user.dart';

part 'collection.g.dart';

@JsonSerializable()
class Collection extends Equatable {
  final String id;
  final String title;
  final String? description;
  @JsonKey(name: 'total_photos')
  final int totalPhotos;
  final User user;
  @JsonKey(name: 'preview_photos')
  final List<PreviewPhoto>? previewPhotos;

  Collection({
    required this.id,
    required this.title,
    required this.description,
    required this.totalPhotos,
    required this.user,
    required this.previewPhotos,
  });

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionToJson(this);

  @override
  List<Object?> get props => [id];
}

@JsonSerializable()
class PreviewPhoto {
  final String id;
  final PreviewUrl urls;

  PreviewPhoto({required this.id, required this.urls});

  factory PreviewPhoto.fromJson(Map<String, dynamic> json) =>
      _$PreviewPhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PreviewPhotoToJson(this);
}

@JsonSerializable()
class PreviewUrl {
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;

  PreviewUrl({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
  });

  factory PreviewUrl.fromJson(Map<String, dynamic> json) =>
      _$PreviewUrlFromJson(json);

  Map<String, dynamic> toJson() => _$PreviewUrlToJson(this);
}
