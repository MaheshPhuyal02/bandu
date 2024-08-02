// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DBUserImpl _$$DBUserImplFromJson(Map<String, dynamic> json) => _$DBUserImpl(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: (json['role'] as List<dynamic>?)?.map((e) => e as String).toList(),
      workAs: json['workAs'] as String?,
      createdAt: _dateTimeFromTimestamp(json['createdAt'] as Timestamp?),
      completed: json['completed'] as bool?,
      provider: json['provider'] as String?,
      projects: (json['projects'] as List<dynamic>?)
          ?.map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DBUserImplToJson(_$DBUserImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'workAs': instance.workAs,
      'createdAt': _dateTimeToTimestamp(instance.createdAt),
      'completed': instance.completed,
      'provider': instance.provider,
      'projects': instance.projects,
    };
