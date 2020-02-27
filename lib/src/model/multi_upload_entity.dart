import 'package:biz_network_main/biz_network_main.dart';
import 'package:json_annotation/json_annotation.dart';

part 'multi_upload_entity.g.dart';

/// 多文件上传
@JsonSerializable()
class MultiUploadEntity extends BaseEntity {

  List<UploadBean> data;

  MultiUploadEntity({msg, code, errorSn, this.data}): super(msg: msg, code: code, errorSn: errorSn);

  factory MultiUploadEntity.fromJson(Map<String, dynamic> srcJson) => _$MultiUploadEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MultiUploadEntityToJson(this);

}


@JsonSerializable()
class UploadBean {

  String contentType;

  String fileId;

  String fileName;

  String fileUrl;

  int lastModified;

  int size;

  UploadBean(this.contentType,this.fileId,this.fileName,this.fileUrl,this.lastModified,this.size,);

  factory UploadBean.fromJson(Map<String, dynamic> srcJson) => _$UploadBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UploadBeanToJson(this);

}


