import 'package:biz_network_main/biz_network_main.dart';
import 'package:json_annotation/json_annotation.dart';

part 'support_type_entity.g.dart';

/// 帮助中心
@JsonSerializable()
class SupportTypeEntity extends BaseEntity {


  List<SupportItemBean> data;


  SupportTypeEntity({msg, code, errorSn, this.data}): super(msg: msg, code: code, errorSn: errorSn);

  factory SupportTypeEntity.fromJson(Map<String, dynamic> srcJson) => _$SupportTypeEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SupportTypeEntityToJson(this);

}


@JsonSerializable()
class SupportItemBean extends Object {

  int associatedScenariosType;

  int contextType;

  String createdAt;

  String createdBy;

  int helpCateId;

  int id;

  int isDelete;

  int sort;

  int status;

  String supportType;

  String title;

  String updatedAt;

  String updatedBy;

  SupportItemBean(this.associatedScenariosType,this.contextType,this.createdAt,this.createdBy,this.helpCateId,this.id,this.isDelete,this.sort,this.status,this.supportType,this.title,this.updatedAt,this.updatedBy,);

  factory SupportItemBean.fromJson(Map<String, dynamic> srcJson) => _$SupportItemBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SupportItemBeanToJson(this);

}
