// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_add_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackAddEntity _$FeedbackAddEntityFromJson(Map<String, dynamic> json) {
  return FeedbackAddEntity(
    msg: json['msg'],
    code: json['code'],
    errorSn: json['errorSn'],
    data: json['data'] as String,
  );
}

Map<String, dynamic> _$FeedbackAddEntityToJson(FeedbackAddEntity instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'errorSn': instance.errorSn,
      'data': instance.data,
    };
