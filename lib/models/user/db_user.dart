import 'package:bandu/models/user/user_project.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'db_user.freezed.dart';
part 'db_user.g.dart';

@freezed
class DBUser with _$DBUser {
  factory DBUser({
    required String uid,
    required String name,
    required String email,
    List<String>? role,
    String? workAs,
    @JsonKey(
        fromJson: _dateTimeFromTimestamp,
        toJson: _dateTimeToTimestamp
    )
    DateTime? createdAt,
    bool? completed,
    String? provider,
    List<Project>? projects,
  }) = _DBUser;

  factory DBUser.fromJson(Map<String, dynamic> json) => _$DBUserFromJson(json);
}

DateTime? _dateTimeFromTimestamp(Timestamp? timestamp) =>
    timestamp?.toDate();

// Converts a DateTime to Firestore Timestamp
Timestamp? _dateTimeToTimestamp(DateTime? dateTime) =>
    dateTime != null ? Timestamp.fromDate(dateTime) : null;