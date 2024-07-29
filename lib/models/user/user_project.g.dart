// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectImpl _$$ProjectImplFromJson(Map<String, dynamic> json) =>
    _$ProjectImpl(
      title: json['title'] as String,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      id: json['id'] as String,
    );

Map<String, dynamic> _$$ProjectImplToJson(_$ProjectImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'id': instance.id,
    };
