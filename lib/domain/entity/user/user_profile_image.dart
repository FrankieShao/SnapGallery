import 'package:json_annotation/json_annotation.dart';

part 'user_profile_image.g.dart';

@JsonSerializable()
class UserProfileImage {
  UserProfileImage({
    required this.small,
    required this.medium,
    required this.large,
  });

  final String small;
  final String medium;
  final String large;

  factory UserProfileImage.fromJson(Map<String, dynamic> json) =>
      _$UserProfileImageFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileImageToJson(this);
}
