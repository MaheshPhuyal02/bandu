import 'package:bandu/models/task/sub_task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  final String id;
  late String title;
  late String description;

  @JsonKey(
    fromJson: _dateTimeFromTimestamp,
    toJson: _dateTimeToTimestamp,
  )
  final DateTime? createdDate;

  @JsonKey(
    fromJson: _dateTimeFromTimestamp,
    toJson: _dateTimeToTimestamp,
  )
  late DateTime? updatedDate;

  @JsonKey(
    fromJson: _dateTimeFromTimestamp,
    toJson: _dateTimeToTimestamp,
  )
  late DateTime? deadline;

  final List<SubTask> subTask;
  late String status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdDate,
    required this.deadline,
    required this.subTask,
    required this.status,
    this.updatedDate,
  });

  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);


  Map<String, dynamic> toJson() => _$TaskToJson(this);
  static DateTime? _dateTimeFromTimestamp(Timestamp? timestamp) =>
      timestamp?.toDate();

  static Timestamp? _dateTimeToTimestamp(DateTime? dateTime) =>
      dateTime != null ? Timestamp.fromDate(dateTime) : null;
}
