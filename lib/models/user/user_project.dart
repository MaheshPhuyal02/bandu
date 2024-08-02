import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_project.freezed.dart';

part 'user_project.g.dart';

@freezed
class Project with _$Project {
  const factory Project({
    required String title,
    @JsonKey(
      fromJson: _dateTimeFromTimestamp,
      toJson: _dateTimeToTimestamp,
    )
    required DateTime? lastUpdated,
    required String id,
    required String? projectPlatform,

  }) = _Project;
  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
}
DateTime? _dateTimeFromTimestamp(Timestamp? timestamp) =>
    timestamp?.toDate();

// Converts a DateTime to Firestore Timestamp
Timestamp? _dateTimeToTimestamp(DateTime? dateTime) =>
    dateTime != null ? Timestamp.fromDate(dateTime) : null;