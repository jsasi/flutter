// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_pay_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepositPayEntity _$DepositPayEntityFromJson(Map<String, dynamic> json) {
  return DepositPayEntity(
    msg: json['msg'],
    code: json['code'],
    errorSn: json['errorSn'],
    data: json['data'] == null
        ? null
        : PayBean.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DepositPayEntityToJson(DepositPayEntity instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'errorSn': instance.errorSn,
      'data': instance.data,
    };

PayBean _$PayBeanFromJson(Map<String, dynamic> json) {
  return PayBean(
    json['alert'] as String,
    (json['amount'] as num)?.toDouble(),
    json['bankName'] as String,
    json['billNo'] as String,
    json['expierTime'] as String,
    json['icon'] as String,
    json['id'] as String,
    json['payTypeName'] as String,
    json['payUrl'] as String,
    json['qrUrl'] as String,
    json['recipientAccount'] as String,
    json['recipientAddress'] as String,
    json['recipientBank'] as String,
    json['recipientName'] as String,
    json['remark'] as String,
    json['trnasfer'] as String,
    json['payStatus'] as int,
  );
}

Map<String, dynamic> _$PayBeanToJson(PayBean instance) => <String, dynamic>{
      'alert': instance.alert,
      'amount': instance.amount,
      'bankName': instance.bankName,
      'billNo': instance.billNo,
      'expierTime': instance.expierTime,
      'icon': instance.icon,
      'id': instance.id,
      'payTypeName': instance.payTypeName,
      'payUrl': instance.payUrl,
      'qrUrl': instance.qrUrl,
      'recipientAccount': instance.recipientAccount,
      'recipientAddress': instance.recipientAddress,
      'recipientBank': instance.recipientBank,
      'recipientName': instance.recipientName,
      'remark': instance.remark,
      'trnasfer': instance.trnasfer,
      'payStatus': instance.payStatus,
    };
