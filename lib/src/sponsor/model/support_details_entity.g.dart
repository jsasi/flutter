// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_details_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportDetailsEntity _$SupportDetailsEntityFromJson(Map<String, dynamic> json) {
  return SupportDetailsEntity(
    msg: json['msg'],
    code: json['code'],
    errorSn: json['errorSn'],
    data: json['data'] == null
        ? null
        : SupportDetailsBean.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SupportDetailsEntityToJson(
        SupportDetailsEntity instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'errorSn': instance.errorSn,
      'data': instance.data,
    };

SupportDetailsBean _$SupportDetailsBeanFromJson(Map<String, dynamic> json) {
  return SupportDetailsBean(
    json['associatedScenariosType'] as int,
    json['contextApp'] as String,
    json['contextPc'] as String,
    json['contextType'] as int,
    json['createdAt'] as String,
    json['createdBy'] as String,
    json['helpCateId'] as int,
    json['id'] as int,
    json['isDelete'] as int,
    json['linkUrl'] as String,
    json['sort'] as int,
    json['status'] as int,
    json['supportType'] as String,
    json['title'] as String,
    json['updatedAt'] as String,
    json['updatedBy'] as String,
  );
}

Map<String, dynamic> _$SupportDetailsBeanToJson(SupportDetailsBean instance) =>
    <String, dynamic>{
      'associatedScenariosType': instance.associatedScenariosType,
      'contextApp': instance.contextApp,
      'contextPc': instance.contextPc,
      'contextType': instance.contextType,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'helpCateId': instance.helpCateId,
      'id': instance.id,
      'isDelete': instance.isDelete,
      'linkUrl': instance.linkUrl,
      'sort': instance.sort,
      'status': instance.status,
      'supportType': instance.supportType,
      'title': instance.title,
      'updatedAt': instance.updatedAt,
      'updatedBy': instance.updatedBy,
    };
