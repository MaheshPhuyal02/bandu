import 'package:freezed_annotation/freezed_annotation.dart';

part 'prompt.freezed.dart';

part 'prompt.g.dart';


@freezed
class Prompt with _$Prompt {
  const factory Prompt({
    required String name,
    required String prompt,
    required bool selected,
  }) = _Prompt;


  factory Prompt.fromJson(Map<String, dynamic> json) => _$PromptFromJson(json);

}