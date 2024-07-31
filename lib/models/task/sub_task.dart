import 'package:freezed_annotation/freezed_annotation.dart';

part 'sub_task.freezed.dart';

part 'sub_task.g.dart';

@freezed
class SubTask with _$SubTask {
  const factory SubTask({
    required String title,
    required String description,
    required DateTime createdDate,
    required DateTime deadline,
    required bool completed,
    required String taskId,
    required String status,

  }) = _SubTask;
  factory SubTask.fromJson(Map<String, dynamic> json) => _$SubTaskFromJson(json);
}