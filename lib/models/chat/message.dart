import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String request,
    required String response,
    required ActionType actionType,


  }) = _Message;
  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}

enum ActionType{
  createTask,
  deleteTask,
  updateTask,
  chat,
}