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
      subTask: (json['subTask'] as List<dynamic>)
          .map((e) => SubTask.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
      updatedDate:
          Task._dateTimeFromTimestamp(json['updatedDate'] as Timestamp?),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'createdDate': Task._dateTimeToTimestamp(instance.createdDate),
      'updatedDate': Task._dateTimeToTimestamp(instance.updatedDate),
      'deadline': Task._dateTimeToTimestamp(instance.deadline),
      'subTask': instance.subTask,
      'status': instance.status,
    };
