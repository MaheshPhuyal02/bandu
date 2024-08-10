import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final String id;
  final String request;
  late String? response;
  late bool? loading;

  @JsonKey(
    fromJson: dateTimeFromTimestamp,
    toJson: dateTimeToTimestamp,
  )
  final DateTime? createdAt;
  final ActionType actionType;

  Message({
    required this.id,
    required this.request,
    this.response,
    this.loading,
    required this.createdAt,
    required this.actionType,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  // Helper methods for Firestore Timestamp conversion
  static DateTime? dateTimeFromTimestamp(Timestamp? timestamp) =>
      timestamp?.toDate();

  static Timestamp? dateTimeToTimestamp(DateTime? dateTime) =>
      dateTime != null ? Timestamp.fromDate(dateTime) : null;
}

enum ActionType {
  chat,
  analyzeRequirements,
  createTask,
  analyzeBudget,
  analyzeTime,
  summarize,
}
