import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'sub_task.freezed.dart';

part 'sub_task.g.dart';

@freezed
class SubTask with _$SubTask {
  const factory SubTask({
    required String id,
    required String title,
    required String description,
    @JsonKey(
      fromJson: _dateTimeFromTimestamp,
      toJson: _dateTimeToTimestamp,
    )
    required DateTime? createdDate,
    @JsonKey(
      fromJson: _dateTimeFromTimestamp,
      toJson: _dateTimeToTimestamp,
    )
    required DateTime? deadline,
    required bool completed,
    required String taskId,
    required String status,

  }) = _SubTask;
  factory SubTask.fromJson(Map<String, dynamic> json) => _$SubTaskFromJson(json);
}

DateTime? _dateTimeFromTimestamp(Timestamp? timestamp) =>
    timestamp?.toDate();

// Converts a DateTime to Firestore Timestamp
Timestamp? _dateTimeToTimestamp(DateTime? dateTime) =>
    dateTime != null ? Timestamp.fromDate(dateTime) : null;