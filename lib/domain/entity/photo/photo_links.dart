import 'package:json_annotation/json_annotation.dart';

part 'photo_links.g.dart';

@JsonSerializable()
class PhotoLinks {
  final String self;
  final String html;
  final String? download;
  final String? download_location;

  PhotoLinks({
    required this.self,
    required this.html,
    required this.download,
    required this.download_location,
  });

  factory PhotoLinks.fromJson(Map<String, dynamic> json) =>
      _$PhotoLinksFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoLinksToJson(this);
}
