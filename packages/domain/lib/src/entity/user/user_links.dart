import 'package:json_annotation/json_annotation.dart';

part 'user_links.g.dart';

@JsonSerializable()
class UserLinks {
  final String self;
  final String html;
  final String photos;
  final String likes;
  final String portfolio;

  UserLinks({
    required this.self,
    required this.html,
    required this.photos,
    required this.likes,
    required this.portfolio,
  });

  factory UserLinks.fromJson(Map<String, dynamic> json) =>
      _$UserLinksFromJson(json);
  Map<String, dynamic> toJson() => _$UserLinksToJson(this);
}
