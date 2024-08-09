// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: json['id'] as String,
      request: json['request'] as String,
      response: json['response'] as String?,
      loading: json['loading'] as bool?,
      createdAt: json['createdAt'] as String,
      actionType: $enumDecode(_$ActionTypeEnumMap, json['actionType']),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'request': instance.request,
      'response': instance.response,
      'loading': instance.loading,
      'createdAt': instance.createdAt,
      'actionType': _$ActionTypeEnumMap[instance.actionType]!,
    };

const _$ActionTypeEnumMap = {
  ActionType.chat: 'chat',
  ActionType.analyzeRequirements: 'analyzeRequirements',
  ActionType.createTask: 'createTask',
  ActionType.analyzeBudget: 'analyzeBudget',
  ActionType.analyzeTime: 'analyzeTime',
  ActionType.summarize: 'summarize',
};
