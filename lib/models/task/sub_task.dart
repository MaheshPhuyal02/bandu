import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sub_task.g.dart';

@JsonSerializable()
class SubTask {
  final String id;
  final String title;
  final String description;

  @JsonKey(
    fromJson: _dateTimeFromTimestamp,
    toJson: _dateTimeToTimestamp,
  )
  final DateTime? createdDate;

  @JsonKey(
    fromJson: _dateTimeFromTimestamp,
    toJson: _dateTimeToTimestamp,
  )
  final DateTime? deadline;

  final bool completed;
  final String taskId;
  String status;

  SubTask({
    required this.id,
    required this.title,
    required this.description,
    required this.createdDate,
    required this.deadline,
    required this.completed,
    required this.taskId,
    required this.status,
  });

  factory SubTask.fromJson(Map<String, dynamic> json) => _$SubTaskFromJson(json);

  Map<String, dynamic> toJson() => _$SubTaskToJson(this);

  // Helper methods for Firestore Timestamp conversion
  static DateTime? _dateTimeFromTimestamp(Timestamp? timestamp) =>
      timestamp?.toDate();

  static Timestamp? _dateTimeToTimestamp(DateTime? dateTime) =>
      dateTime != null ? Timestamp.fromDate(dateTime) : null;
}
