// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_pay_type_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepositPayTypeEntity _$DepositPayTypeEntityFromJson(Map<String, dynamic> json) {
  return DepositPayTypeEntity(
    msg: json['msg'],
    code: json['code'],
    errorSn: json['errorSn'],
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DepositPayTypeEntityToJson(
        DepositPayTypeEntity instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'errorSn': instance.errorSn,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['merchantId'] as String,
    (json['typeList'] as List)
        ?.map((e) => e == null
            ? null
            : TypeEntryBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['userId'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'merchantId': instance.merchantId,
      'typeList': instance.typeList,
      'userId': instance.userId,
    };

TypeEntryBean _$TypeEntryBeanFromJson(Map<String, dynamic> json) {
  return TypeEntryBean(
    json['depositRate'] as String,
    json['deposit_max_amount'] as String,
    json['deposit_min_amount'] as String,
    json['icon'] as String,
    json['maxDailyDiscount'] as String,
    json['pay_type_id'] as String,
    json['recommend'] as int,
    json['sort'] as int,
    json['transfer'] as String,
    json['typeName'] as String,
    json['userName'] as String,
  );
}

Map<String, dynamic> _$TypeEntryBeanToJson(TypeEntryBean instance) =>
    <String, dynamic>{
      'depositRate': instance.depositRate,
      'deposit_max_amount': instance.deposit_max_amount,
      'deposit_min_amount': instance.deposit_min_amount,
      'icon': instance.icon,
      'maxDailyDiscount': instance.maxDailyDiscount,
      'pay_type_id': instance.pay_type_id,
      'recommend': instance.recommend,
      'sort': instance.sort,
      'transfer': instance.transfer,
      'typeName': instance.typeName,
      'userName': instance.userName,
    };
