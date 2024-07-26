import 'package:bandu/models/task/sub_task.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

part 'task.g.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String title,
    required String description,
    required DateTime createdDate,
    required DateTime deadline,
    required bool completed,
    required List<SubTask> subTask,

  }) = _Task;
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}