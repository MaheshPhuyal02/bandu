// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubTask _$SubTaskFromJson(Map<String, dynamic> json) => SubTask(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdDate:
          SubTask._dateTimeFromTimestamp(json['createdDate'] as Timestamp?),
      deadline: SubTask._dateTimeFromTimestamp(json['deadline'] as Timestamp?),
      completed: json['completed'] as bool,
      taskId: json['taskId'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$SubTaskToJson(SubTask instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'createdDate': SubTask._dateTimeToTimestamp(instance.createdDate),
      'deadline': SubTask._dateTimeToTimestamp(instance.deadline),
      'completed': instance.completed,
      'taskId': instance.taskId,
      'status': instance.status,
    };
