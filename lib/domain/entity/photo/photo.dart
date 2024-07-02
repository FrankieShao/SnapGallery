import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:snapgallery/domain/entity/photo/photo_links.dart';

import 'base_photo.dart';
import '../user/user.dart';
import 'photo_url.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo extends Equatable implements BasePhoto {
  final String id;
  final int width;
  final int height;
  final int likes;
  final String? description;
  final User user;
  final Urls urls;
  final PhotoLinks links;

  const Photo({
    required this.id,
    required this.width,
    required this.height,
    required this.likes,
    required this.description,
    required this.user,
    required this.urls,
    required this.links,
  });

  @override
  int get w {
    return width;
  }

  @override
  int get h {
    return height;
  }

  @override
  String get resourceUrl {
    return urls.small;
  }

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);

  @override
  List<Object> get props => [id];
}
