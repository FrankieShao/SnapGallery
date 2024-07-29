// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      username: json['username'] as String,
      name: json['name'] as String,
      location: json['location'] as String?,
      profileImage: UserProfileImage.fromJson(
          json['profile_image'] as Map<String, dynamic>),
      totalLikes: (json['total_likes'] as num).toInt(),
      totalPhotos: (json['total_photos'] as num).toInt(),
      totalCollections: (json['total_collections'] as num).toInt(),
      followersCount: (json['followers_count'] as num?)?.toInt(),
      followingCount: (json['following_count'] as num?)?.toInt(),
      downloads: (json['downloads'] as num?)?.toInt(),
      bio: json['bio'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'bio': instance.bio,
      'total_likes': instance.totalLikes,
      'total_photos': instance.totalPhotos,
      'total_collections': instance.totalCollections,
      'location': instance.location,
      'profile_image': instance.profileImage,
      'followers_count': instance.followersCount,
      'following_count': instance.followingCount,
      'downloads': instance.downloads,
    };
