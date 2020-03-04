import 'package:biz_network_main/biz_network_main.dart';
import 'package:json_annotation/json_annotation.dart';

part 'deposit_pay_entity.g.dart';


@JsonSerializable()
class DepositPayEntity extends BaseEntity {

  PayBean data;

  DepositPayEntity({msg, code, errorSn, this.data}): super(msg: msg, code: code, errorSn: errorSn);

  factory DepositPayEntity.fromJson(Map<String, dynamic> srcJson) => _$DepositPayEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DepositPayEntityToJson(this);

}


@JsonSerializable()
class PayBean  {

  String alert;

  double amount;

  String bankName;

  String billNo;

  String expierTime;

  String icon;

  String id;

  String payTypeName;

  String payUrl;

  String qrUrl;

  String recipientAccount;

  String recipientAddress;

  String recipientBank;

  String recipientName;

  String remark;

  String trnasfer;

  int payStatus;

  PayBean(this.alert,this.amount,this.bankName,this.billNo,this.expierTime,this.icon,this.id,this.payTypeName,this.payUrl,this.qrUrl,this.recipientAccount,this.recipientAddress,this.recipientBank,this.recipientName,this.remark,this.trnasfer,this.payStatus,);

  factory PayBean.fromJson(Map<String, dynamic> srcJson) => _$PayBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PayBeanToJson(this);

}


