import 'package:biz_network_main/biz_network_main.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_entity.g.dart';

/// 客服问题
@JsonSerializable()
class ServiceEntity extends BaseEntity {

	List<ServiceItemBean> data;

	ServiceEntity({msg, code, errorSn, this.data}): super(msg: msg, code: code, errorSn: errorSn);

	factory ServiceEntity.fromJson(Map<String, dynamic> srcJson) => _$ServiceEntityFromJson(srcJson);

	Map<String, dynamic> toJson() => _$ServiceEntityToJson(this);

}


@JsonSerializable()
class ServiceItemBean {

	String createdAt;

	String createdBy;

	String iconUrl;

	int id;

	int isDelete;

	String name;

	String shortTitle;

	String updatedAt;
	String linkUrl;

	ServiceItemBean(this.createdAt,this.createdBy,this.iconUrl,this.id,this.isDelete,this.name,this.shortTitle,this.updatedAt,this.linkUrl,);

	factory ServiceItemBean.fromJson(Map<String, dynamic> srcJson) => _$ServiceItemBeanFromJson(srcJson);

	Map<String, dynamic> toJson() => _$ServiceItemBeanToJson(this);

}


