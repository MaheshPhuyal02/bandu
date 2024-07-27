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
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      completed: json['completed'] as bool?,
      provider: json['provider'] as String?,
      project: json['project'] == null
          ? null
          : Project.fromJson(json['project'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DBUserImplToJson(_$DBUserImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'role': instance.role,
      'workAs': instance.workAs,
      'createdAt': instance.createdAt?.toIso8601String(),
      'completed': instance.completed,
      'provider': instance.provider,
      'project': instance.project,
    };
