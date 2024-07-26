// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      title: json['title'] as String,
      description: json['description'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String),
      deadline: DateTime.parse(json['deadline'] as String),
      completed: json['completed'] as bool,
      subTask: (json['subTask'] as List<dynamic>)
          .map((e) => SubTask.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'createdDate': instance.createdDate.toIso8601String(),
      'deadline': instance.deadline.toIso8601String(),
      'completed': instance.completed,
      'subTask': instance.subTask,
    };
