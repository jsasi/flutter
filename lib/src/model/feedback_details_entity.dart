import 'package:biz_network_main/biz_network_main.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feedback_details_entity.g.dart';


@JsonSerializable()
class FeedbackDetailsEntity extends BaseEntity {

  FeedbackDetailsBean data;

  FeedbackDetailsEntity({msg, code, errorSn, this.data}): super(msg: msg, code: code, errorSn: errorSn);

  factory FeedbackDetailsEntity.fromJson(Map<String, dynamic> srcJson) => _$FeedbackDetailsEntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FeedbackDetailsEntityToJson(this);

}


@JsonSerializable()
class FeedbackDetailsBean  {

  int category;

  String content;

  String createdAt;

  String description;

  String feedbackContent;

  int id;

  int memberId;

  String memberName;

  int pageNum;

  int pageSize;

  String picUrls;

  String siteName;

  int status;

  String updatedAt;

  FeedbackDetailsBean(this.category,this.content,this.createdAt,this.description,this.feedbackContent,this.id,this.memberId,this.memberName,this.pageNum,this.pageSize,this.picUrls,this.siteName,this.status,this.updatedAt,);

  factory FeedbackDetailsBean.fromJson(Map<String, dynamic> srcJson) => _$FeedbackDetailsBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FeedbackDetailsBeanToJson(this);

}


