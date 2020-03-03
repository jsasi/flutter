// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_que_type_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeeQueTypeEntity _$FeeQueTypeEntityFromJson(Map<String, dynamic> json) {
  return FeeQueTypeEntity(
    msg: json['msg'],
    code: json['code'],
    errorSn: json['errorSn'],
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : FeeQueTypeItemBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FeeQueTypeEntityToJson(FeeQueTypeEntity instance) =>
    <String, dynamic>{
      'code': instance.code,
      'errorSn': instance.errorSn,
      'msg': instance.msg,
      'data': instance.data,
    };

FeeQueTypeItemBean _$FeeQueTypeItemBeanFromJson(Map<String, dynamic> json) {
  return FeeQueTypeItemBean(
    json['code'] as String,
    json['dictValue'] as String,
    json['id'] as int,
  );
}

Map<String, dynamic> _$FeeQueTypeItemBeanToJson(FeeQueTypeItemBean instance) =>
    <String, dynamic>{
      'code': instance.code,
      'dictValue': instance.dictValue,
      'id': instance.id,
    };
