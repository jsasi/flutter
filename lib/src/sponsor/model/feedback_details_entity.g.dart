// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_details_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackDetailsEntity _$FeedbackDetailsEntityFromJson(
    Map<String, dynamic> json) {
  return FeedbackDetailsEntity(
    msg: json['msg'],
    code: json['code'],
    errorSn: json['errorSn'],
    data: json['data'] == null
        ? null
        : FeedbackDetailsBean.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FeedbackDetailsEntityToJson(
        FeedbackDetailsEntity instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'errorSn': instance.errorSn,
      'data': instance.data,
    };

FeedbackDetailsBean _$FeedbackDetailsBeanFromJson(Map<String, dynamic> json) {
  return FeedbackDetailsBean(
    json['category'] as int,
    json['content'] as String,
    json['createdAt'] as String,
    json['description'] as String,
    json['feedbackContent'] as String,
    json['id'] as int,
    json['memberId'] as int,
    json['memberName'] as String,
    json['pageNum'] as int,
    json['pageSize'] as int,
    json['picUrls'] as String,
    json['siteName'] as String,
    json['status'] as int,
    json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$FeedbackDetailsBeanToJson(
        FeedbackDetailsBean instance) =>
    <String, dynamic>{
      'category': instance.category,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'description': instance.description,
      'feedbackContent': instance.feedbackContent,
      'id': instance.id,
      'memberId': instance.memberId,
      'memberName': instance.memberName,
      'pageNum': instance.pageNum,
      'pageSize': instance.pageSize,
      'picUrls': instance.picUrls,
      'siteName': instance.siteName,
      'status': instance.status,
      'updatedAt': instance.updatedAt,
    };
