// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_links.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoLinks _$PhotoLinksFromJson(Map<String, dynamic> json) => PhotoLinks(
      self: json['self'] as String,
      html: json['html'] as String,
      download: json['download'] as String?,
      download_location: json['download_location'] as String?,
    );

Map<String, dynamic> _$PhotoLinksToJson(PhotoLinks instance) =>
    <String, dynamic>{
      'self': instance.self,
      'html': instance.html,
      'download': instance.download,
      'download_location': instance.download_location,
    };
