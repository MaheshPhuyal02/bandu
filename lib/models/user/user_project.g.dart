// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectImpl _$$ProjectImplFromJson(Map<String, dynamic> json) =>
    _$ProjectImpl(
      title: json['title'] as String,
      lastUpdated: _dateTimeFromTimestamp(json['lastUpdated'] as Timestamp?),
      id: json['id'] as String,
      projectPlatform: json['projectPlatform'] as String?,
    );

Map<String, dynamic> _$$ProjectImplToJson(_$ProjectImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'lastUpdated': _dateTimeToTimestamp(instance.lastUpdated),
      'id': instance.id,
      'projectPlatform': instance.projectPlatform,
    };
