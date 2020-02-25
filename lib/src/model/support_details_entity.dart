import 'package:biz_network_main/biz_network_main.dart';
import 'package:json_annotation/json_annotation.dart';

part 'support_details_entity.g.dart';

@JsonSerializable()
class SupportDetailsEntity extends BaseEntity {
  SupportDetailsBean data;

  SupportDetailsEntity({msg, code, errorSn, this.data})
      : super(msg: msg, code: code, errorSn: errorSn);

  factory SupportDetailsEntity.fromJson(Map<String, dynamic> srcJson) =>
      _$SupportDetailsEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SupportDetailsEntityToJson(this);
}


@JsonSerializable()
class SupportDetailsBean  {

  int associatedScenariosType;

  String contextApp;

  String contextPc;

  int contextType;

  String createdAt;

  String createdBy;

  int helpCateId;

  int id;

  int isDelete;

  String linkUrl;

  int sort;

  int status;

  String supportType;

  String title;

  String updatedAt;

  String updatedBy;

  SupportDetailsBean(this.associatedScenariosType,this.contextApp,this.contextPc,this.contextType,this.createdAt,this.createdBy,this.helpCateId,this.id,this.isDelete,this.linkUrl,this.sort,this.status,this.supportType,this.title,this.updatedAt,this.updatedBy,);

  factory SupportDetailsBean.fromJson(Map<String, dynamic> srcJson) => _$SupportDetailsBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SupportDetailsBeanToJson(this);

}


