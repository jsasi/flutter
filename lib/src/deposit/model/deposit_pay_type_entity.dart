import 'package:biz_network_main/biz_network_main.dart';
import 'package:json_annotation/json_annotation.dart';

part 'deposit_pay_type_entity.g.dart';


@JsonSerializable()
class DepositPayTypeEntity extends BaseEntity {


  Data data;


  DepositPayTypeEntity({msg, code, errorSn, this.data}): super(msg: msg, code: code, errorSn: errorSn);

  factory DepositPayTypeEntity.fromJson(Map<String, dynamic> srcJson) => _$DepositPayTypeEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DepositPayTypeEntityToJson(this);

}


@JsonSerializable()
class Data  {

  String merchantId;

  List<TypeEntryBean> typeList;

  String userId;

  Data(this.merchantId,this.typeList,this.userId,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

@JsonSerializable()
class TypeEntryBean  {

  String depositRate;

  String deposit_max_amount;

  String deposit_min_amount;

  String icon;

  String maxDailyDiscount;

  String pay_type_id;

  int recommend;

  int sort;

  String transfer;

  String typeName;

  String userName;

  TypeEntryBean(this.depositRate,this.deposit_max_amount,this.deposit_min_amount,this.icon,this.maxDailyDiscount,this.pay_type_id,this.recommend,this.sort,this.transfer,this.typeName,this.userName,);

  factory TypeEntryBean.fromJson(Map<String, dynamic> srcJson) => _$TypeEntryBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TypeEntryBeanToJson(this);

}



