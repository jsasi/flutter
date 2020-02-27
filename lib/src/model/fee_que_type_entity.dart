import 'package:biz_network_main/biz_network_main.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fee_que_type_entity.g.dart';

/// 意见反馈问题类型
@JsonSerializable()
class FeeQueTypeEntity extends BaseEntity {


  String msg;

  List<FeeQueTypeItemBean> data;

  FeeQueTypeEntity({msg, code, errorSn, this.data}): super(msg: msg, code: code, errorSn: errorSn);

  factory FeeQueTypeEntity.fromJson(Map<String, dynamic> srcJson) => _$FeeQueTypeEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FeeQueTypeEntityToJson(this);

}


@JsonSerializable()
class FeeQueTypeItemBean {

  String code;

  String dictValue;

  int id;

  FeeQueTypeItemBean(this.code,this.dictValue,this.id,);

  factory FeeQueTypeItemBean.fromJson(Map<String, dynamic> srcJson) => _$FeeQueTypeItemBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FeeQueTypeItemBeanToJson(this);

}


