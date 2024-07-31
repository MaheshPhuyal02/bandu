// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubTaskImpl _$$SubTaskImplFromJson(Map<String, dynamic> json) =>
    _$SubTaskImpl(
      title: json['title'] as String,
      description: json['description'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String),
      deadline: DateTime.parse(json['deadline'] as String),
      completed: json['completed'] as bool,
      taskId: json['taskId'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$SubTaskImplToJson(_$SubTaskImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'createdDate': instance.createdDate.toIso8601String(),
      'deadline': instance.deadline.toIso8601String(),
      'completed': instance.completed,
      'taskId': instance.taskId,
      'status': instance.status,
    };
