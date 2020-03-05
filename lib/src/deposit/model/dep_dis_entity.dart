import 'package:biz_network_main/biz_network_main.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dep_dis_entity.g.dart';


/// 优惠列表
@JsonSerializable()
class DepDisEntity extends BaseEntity {

  List<DepDisBean> data;

  DepDisEntity({msg, code, errorSn, this.data}): super(msg: msg, code: code, errorSn: errorSn);

  factory DepDisEntity.fromJson(Map<String, dynamic> srcJson) => _$DepDisEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DepDisEntityToJson(this);

}


@JsonSerializable()
class DepDisBean  {

  String depositRate;

  String editor;

  String maxDailyDiscount;

  int memberGrade;

  String payType;

  DepDisBean(this.depositRate,this.editor,this.maxDailyDiscount,this.memberGrade,this.payType,);

  factory DepDisBean.fromJson(Map<String, dynamic> srcJson) => _$DepDisBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DepDisBeanToJson(this);

}

  
