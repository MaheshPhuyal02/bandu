// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdDate:
          Task._dateTimeFromTimestamp(json['createdDate'] as Timestamp?),
      deadline: Task._dateTimeFromTimestamp(json['deadline'] as Timestamp?),
      completed: json['completed'] as bool,
      subTask: (json['subTask'] as List<dynamic>)
          .map((e) => SubTask.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'createdDate': Task._dateTimeToTimestamp(instance.createdDate),
      'deadline': Task._dateTimeToTimestamp(instance.deadline),
      'completed': instance.completed,
      'subTask': instance.subTask,
      'status': instance.status,
    };
