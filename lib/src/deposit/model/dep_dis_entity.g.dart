// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dep_dis_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepDisEntity _$DepDisEntityFromJson(Map<String, dynamic> json) {
  return DepDisEntity(
    msg: json['msg'],
    code: json['code'],
    errorSn: json['errorSn'],
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : DepDisBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DepDisEntityToJson(DepDisEntity instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'errorSn': instance.errorSn,
      'data': instance.data,
    };

DepDisBean _$DepDisBeanFromJson(Map<String, dynamic> json) {
  return DepDisBean(
    json['depositRate'] as String,
    json['editor'] as String,
    json['maxDailyDiscount'] as String,
    json['memberGrade'] as int,
    json['payType'] as String,
  );
}

Map<String, dynamic> _$DepDisBeanToJson(DepDisBean instance) =>
    <String, dynamic>{
      'depositRate': instance.depositRate,
      'editor': instance.editor,
      'maxDailyDiscount': instance.maxDailyDiscount,
      'memberGrade': instance.memberGrade,
      'payType': instance.payType,
    };
