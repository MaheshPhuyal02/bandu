// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prompt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PromptImpl _$$PromptImplFromJson(Map<String, dynamic> json) => _$PromptImpl(
      name: json['name'] as String,
      prompt: json['prompt'] as String,
      selected: json['selected'] as bool,
    );

Map<String, dynamic> _$$PromptImplToJson(_$PromptImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'prompt': instance.prompt,
      'selected': instance.selected,
    };
