// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collection _$CollectionFromJson(Map<String, dynamic> json) => Collection(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      totalPhotos: (json['total_photos'] as num).toInt(),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      previewPhotos: (json['preview_photos'] as List<dynamic>?)
          ?.map((e) => PreviewPhoto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'total_photos': instance.totalPhotos,
      'user': instance.user,
      'preview_photos': instance.previewPhotos,
    };

PreviewPhoto _$PreviewPhotoFromJson(Map<String, dynamic> json) => PreviewPhoto(
      id: json['id'] as String,
      urls: PreviewUrl.fromJson(json['urls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreviewPhotoToJson(PreviewPhoto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'urls': instance.urls,
    };

PreviewUrl _$PreviewUrlFromJson(Map<String, dynamic> json) => PreviewUrl(
      raw: json['raw'] as String,
      full: json['full'] as String,
      regular: json['regular'] as String,
      small: json['small'] as String,
      thumb: json['thumb'] as String,
    );

Map<String, dynamic> _$PreviewUrlToJson(PreviewUrl instance) =>
    <String, dynamic>{
      'raw': instance.raw,
      'full': instance.full,
      'regular': instance.regular,
      'small': instance.small,
      'thumb': instance.thumb,
    };
