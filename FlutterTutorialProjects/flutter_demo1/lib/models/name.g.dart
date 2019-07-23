// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'name.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Name _$NameFromJson(Map<String, dynamic> json) {
  return Name()
    ..first_name = json['first_name'] as String
    ..last_name = json['last_name'] as String;
}

Map<String, dynamic> _$NameToJson(Name instance) => <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name
    };
