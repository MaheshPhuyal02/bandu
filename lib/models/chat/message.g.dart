// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as String,
      request: json['request'] as String,
      response: json['response'] as String?,
      loading: json['loading'] as bool?,
      createdAt: Message.dateTimeFromTimestamp(json['createdAt'] as Timestamp?),
      actionType: $enumDecode(_$ActionTypeEnumMap, json['actionType']),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'request': instance.request,
      'response': instance.response,
      'loading': instance.loading,
      'createdAt': Message.dateTimeToTimestamp(instance.createdAt),
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
