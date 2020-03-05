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
    alert: json['alert'] as String,
    amount: (json['amount'] as num)?.toDouble(),
    bankName: json['bankName'] as String,
    billNo: json['billNo'] as String,
    expierTime: json['expierTime'] as String,
    icon: json['icon'] as String,
    id: json['id'] as String,
    payTypeName: json['payTypeName'] as String,
    payUrl: json['payUrl'] as String,
    qrUrl: json['qrUrl'] as String,
    recipientAccount: json['recipientAccount'] as String,
    recipientAddress: json['recipientAddress'] as String,
    recipientBank: json['recipientBank'] as String,
    recipientName: json['recipientName'] as String,
    remark: json['remark'] as String,
    trnasfer: json['trnasfer'] as String,
    payStatus: json['payStatus'] as int,
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
