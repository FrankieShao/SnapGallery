class Topic {
  final String id;
  final String title;
  final String slug;
  final String description;
  final String status;

  Topic(
      {required this.id,
      required this.title,
      required this.slug,
      required this.description,
      required this.status});

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json['id'] as String,
        title: json['title'] as String,
        slug: json['slug'] as String,
        description: json['description'] as String,
        status: json['status'] as String,
      );

  Map<String, dynamic> toJson() => _$TopicToJson(this);

  Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
        'id': instance.id,
        'title': instance.title,
        'slug': instance.slug,
        'description': instance.description,
        'status': instance.status,
      };
}
