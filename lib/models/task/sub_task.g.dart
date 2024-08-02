// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubTaskImpl _$$SubTaskImplFromJson(Map<String, dynamic> json) =>
    _$SubTaskImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdDate: _dateTimeFromTimestamp(json['createdDate'] as Timestamp?),
      deadline: _dateTimeFromTimestamp(json['deadline'] as Timestamp?),
      completed: json['completed'] as bool,
      taskId: json['taskId'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$SubTaskImplToJson(_$SubTaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'createdDate': _dateTimeToTimestamp(instance.createdDate),
      'deadline': _dateTimeToTimestamp(instance.deadline),
      'completed': instance.completed,
      'taskId': instance.taskId,
      'status': instance.status,
    };
