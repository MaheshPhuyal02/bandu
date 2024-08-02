// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdDate: _dateTimeFromTimestamp(json['createdDate'] as Timestamp?),
      deadline: _dateTimeFromTimestamp(json['deadline'] as Timestamp?),
      completed: json['completed'] as bool,
      subTask: (json['subTask'] as List<dynamic>)
          .map((e) => SubTask.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'createdDate': _dateTimeToTimestamp(instance.createdDate),
      'deadline': _dateTimeToTimestamp(instance.deadline),
      'completed': instance.completed,
      'subTask': instance.subTask,
      'status': instance.status,
    };
