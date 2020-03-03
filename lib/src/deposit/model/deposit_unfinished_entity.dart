import 'package:biz_network_main/biz_network_main.dart';
import 'package:json_annotation/json_annotation.dart';

part 'deposit_unfinished_entity.g.dart';


@JsonSerializable()
class DepositUnfinishedEntity extends BaseEntity {

  DepositUnfinishedBean data;

  DepositUnfinishedEntity({msg, code, errorSn, this.data}): super(msg: msg, code: code, errorSn: errorSn);

  factory DepositUnfinishedEntity.fromJson(Map<String, dynamic> srcJson) => _$DepositUnfinishedEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DepositUnfinishedEntityToJson(this);

}


@JsonSerializable()
class DepositUnfinishedBean  {

  String bankName;

  String expireTime;

  String icon;

  String moreSwitch;

  String payTypeName;

  Records records;

  String transfer;

  DepositUnfinishedBean(this.bankName,this.expireTime,this.icon,this.moreSwitch,this.payTypeName,this.records,this.transfer,);

  factory DepositUnfinishedBean.fromJson(Map<String, dynamic> srcJson) => _$DepositUnfinishedBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DepositUnfinishedBeanToJson(this);

}


@JsonSerializable()
class Records extends Object {

  String billNo;

  int category;

  String clientIp;

  int clientType;

  String createdAt;

  String depositAccount;

  String despositName;

  String financeRemark;

  double flowRatio;

  String id;

  int memberGrade;

  String memberId;

  String memberUsername;

  String operator;

  double orderAmount;

  double payAmount;

  String payChannel;

  int payChannelIndex;

  String payMessage;

  String payResult;

  int paySeq;

  int payStatus;

  int payType;

  String qrUrl;

  String qrUrlOffline;

  double rebateAmount;

  String recipientAccount;

  String recipientAddress;

  String recipientBank;

  String recipientCode;

  String recipientName;

  double scoreAmount;

  String topId;

  String transferAccount;

  String typayOrderId;

  String updatedAt;

  Records(this.billNo,this.category,this.clientIp,this.clientType,this.createdAt,this.depositAccount,this.despositName,this.financeRemark,this.flowRatio,this.id,this.memberGrade,this.memberId,this.memberUsername,this.operator,this.orderAmount,this.payAmount,this.payChannel,this.payChannelIndex,this.payMessage,this.payResult,this.paySeq,this.payStatus,this.payType,this.qrUrl,this.qrUrlOffline,this.rebateAmount,this.recipientAccount,this.recipientAddress,this.recipientBank,this.recipientCode,this.recipientName,this.scoreAmount,this.topId,this.transferAccount,this.typayOrderId,this.updatedAt,);

  factory Records.fromJson(Map<String, dynamic> srcJson) => _$RecordsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecordsToJson(this);

}


