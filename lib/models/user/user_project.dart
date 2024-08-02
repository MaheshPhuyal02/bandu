import 'package:freezed_annotation/freezed_annotation.dart';


part 'user_project.freezed.dart';

part 'user_project.g.dart';

@freezed
class Project with _$Project {
  const factory Project({
    required String title,
    required DateTime lastUpdated,
    required String id,
    required String? projectPlatform,

  }) = _Project;
  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
}
