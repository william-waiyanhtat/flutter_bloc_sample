// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post()
    ..id = json['id'] as num
    ..name = json['name'] == null
        ? null
        : Name.fromJson(json['name'] as Map<String, dynamic>)
    ..title = json['title'] as String
    ..body = json['body'] as String;
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'body': instance.body
    };
