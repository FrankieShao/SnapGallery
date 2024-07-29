import 'package:json_annotation/json_annotation.dart';
import 'user_profile_image.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    required this.id,
    required this.username,
    required this.name,
    required this.location,
    required this.profileImage,
    required this.totalLikes,
    required this.totalPhotos,
    required this.totalCollections,
    required this.followersCount,
    required this.followingCount,
    required this.downloads,
    required this.bio,
  });

  final String id;
  final String username;
  final String name;
  final String? bio;
  @JsonKey(name: 'total_likes')
  final int totalLikes;
  @JsonKey(name: 'total_photos')
  final int totalPhotos;
  @JsonKey(name: 'total_collections')
  final int totalCollections;
  final String? location;
  @JsonKey(name: 'profile_image')
  final UserProfileImage profileImage;
  @JsonKey(name: 'followers_count')
  final int? followersCount;
  @JsonKey(name: 'following_count')
  final int? followingCount;
  final int? downloads;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
