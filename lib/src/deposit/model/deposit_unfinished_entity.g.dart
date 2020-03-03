// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_unfinished_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepositUnfinishedEntity _$DepositUnfinishedEntityFromJson(
    Map<String, dynamic> json) {
  return DepositUnfinishedEntity(
    msg: json['msg'],
    code: json['code'],
    errorSn: json['errorSn'],
    data: json['data'] == null
        ? null
        : DepositUnfinishedBean.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DepositUnfinishedEntityToJson(
        DepositUnfinishedEntity instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'errorSn': instance.errorSn,
      'data': instance.data,
    };

DepositUnfinishedBean _$DepositUnfinishedBeanFromJson(
    Map<String, dynamic> json) {
  return DepositUnfinishedBean(
    json['bankName'] as String,
    json['expireTime'] as String,
    json['icon'] as String,
    json['moreSwitch'] as String,
    json['payTypeName'] as String,
    json['records'] == null
        ? null
        : Records.fromJson(json['records'] as Map<String, dynamic>),
    json['transfer'] as String,
  );
}

Map<String, dynamic> _$DepositUnfinishedBeanToJson(
        DepositUnfinishedBean instance) =>
    <String, dynamic>{
      'bankName': instance.bankName,
      'expireTime': instance.expireTime,
      'icon': instance.icon,
      'moreSwitch': instance.moreSwitch,
      'payTypeName': instance.payTypeName,
      'records': instance.records,
      'transfer': instance.transfer,
    };

Records _$RecordsFromJson(Map<String, dynamic> json) {
  return Records(
    json['billNo'] as String,
    json['category'] as int,
    json['clientIp'] as String,
    json['clientType'] as int,
    json['createdAt'] as String,
    json['depositAccount'] as String,
    json['despositName'] as String,
    json['financeRemark'] as String,
    (json['flowRatio'] as num)?.toDouble(),
    json['id'] as String,
    json['memberGrade'] as int,
    json['memberId'] as String,
    json['memberUsername'] as String,
    json['operator'] as String,
    (json['orderAmount'] as num)?.toDouble(),
    (json['payAmount'] as num)?.toDouble(),
    json['payChannel'] as String,
    json['payChannelIndex'] as int,
    json['payMessage'] as String,
    json['payResult'] as String,
    json['paySeq'] as int,
    json['payStatus'] as int,
    json['payType'] as int,
    json['qrUrl'] as String,
    json['qrUrlOffline'] as String,
    (json['rebateAmount'] as num)?.toDouble(),
    json['recipientAccount'] as String,
    json['recipientAddress'] as String,
    json['recipientBank'] as String,
    json['recipientCode'] as String,
    json['recipientName'] as String,
    (json['scoreAmount'] as num)?.toDouble(),
    json['topId'] as String,
    json['transferAccount'] as String,
    json['typayOrderId'] as String,
    json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$RecordsToJson(Records instance) => <String, dynamic>{
      'billNo': instance.billNo,
      'category': instance.category,
      'clientIp': instance.clientIp,
      'clientType': instance.clientType,
      'createdAt': instance.createdAt,
      'depositAccount': instance.depositAccount,
      'despositName': instance.despositName,
      'financeRemark': instance.financeRemark,
      'flowRatio': instance.flowRatio,
      'id': instance.id,
      'memberGrade': instance.memberGrade,
      'memberId': instance.memberId,
      'memberUsername': instance.memberUsername,
      'operator': instance.operator,
      'orderAmount': instance.orderAmount,
      'payAmount': instance.payAmount,
      'payChannel': instance.payChannel,
      'payChannelIndex': instance.payChannelIndex,
      'payMessage': instance.payMessage,
      'payResult': instance.payResult,
      'paySeq': instance.paySeq,
      'payStatus': instance.payStatus,
      'payType': instance.payType,
      'qrUrl': instance.qrUrl,
      'qrUrlOffline': instance.qrUrlOffline,
      'rebateAmount': instance.rebateAmount,
      'recipientAccount': instance.recipientAccount,
      'recipientAddress': instance.recipientAddress,
      'recipientBank': instance.recipientBank,
      'recipientCode': instance.recipientCode,
      'recipientName': instance.recipientName,
      'scoreAmount': instance.scoreAmount,
      'topId': instance.topId,
      'transferAccount': instance.transferAccount,
      'typayOrderId': instance.typayOrderId,
      'updatedAt': instance.updatedAt,
    };
