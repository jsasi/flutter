import 'package:biz_network_main/biz_network_main.dart';
import 'package:json_annotation/json_annotation.dart';

part 'deposit_notice_entity.g.dart';


@JsonSerializable()
class DepNoticeEntity extends BaseEntity {

  List<NoticeEntry> data;

  DepNoticeEntity({msg, code, errorSn, this.data}): super(msg: msg, code: code, errorSn: errorSn);

  factory DepNoticeEntity.fromJson(Map<String, dynamic> srcJson) => _$DepNoticeEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DepNoticeEntityToJson(this);

}


@JsonSerializable()
class NoticeEntry  {

  String appImage;

  String appImageUrl;

  int category;

  String clients;

  String content;

  String createdAt;

  String createdBy;

  int id;

  int sysStatus;

  String title;

  String updatedAt;

  String updatedBy;

  String url;

  NoticeEntry(this.appImage,this.appImageUrl,this.category,this.clients,this.content,this.createdAt,this.createdBy,this.id,this.sysStatus,this.title,this.updatedAt,this.updatedBy,this.url,);

  factory NoticeEntry.fromJson(Map<String, dynamic> srcJson) => _$NoticeEntryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NoticeEntryToJson(this);

}


