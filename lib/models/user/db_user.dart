import 'package:bandu/models/user/user_project.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'db_user.freezed.dart';

part 'db_user.g.dart';

@freezed
class DBUser with _$DBUser {
  const factory DBUser({
    required String uid,
    required String name,
    required String email,
    List<String>? role,
    String? workAs,
    DateTime? createdAt,
    bool? completed,
    String? provider,
    List<Project>? projects,
  }) = _DBUser;

  factory DBUser.fromJson(Map<String, dynamic> json) => _$DBUserFromJson(json);
}
