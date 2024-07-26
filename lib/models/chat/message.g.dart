// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: json['id'] as String,
      request: json['request'] as String,
      response: json['response'] as String,
      actionType: $enumDecode(_$ActionTypeEnumMap, json['actionType']),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'request': instance.request,
      'response': instance.response,
      'actionType': _$ActionTypeEnumMap[instance.actionType]!,
    };

const _$ActionTypeEnumMap = {
  ActionType.createTask: 'createTask',
  ActionType.deleteTask: 'deleteTask',
  ActionType.updateTask: 'updateTask',
  ActionType.chat: 'chat',
};
