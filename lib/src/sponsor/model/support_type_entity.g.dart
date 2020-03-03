// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_type_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportTypeEntity _$SupportTypeEntityFromJson(Map<String, dynamic> json) {
  return SupportTypeEntity(
    msg: json['msg'],
    code: json['code'],
    errorSn: json['errorSn'],
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : SupportItemBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SupportTypeEntityToJson(SupportTypeEntity instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'errorSn': instance.errorSn,
      'data': instance.data,
    };

SupportItemBean _$SupportItemBeanFromJson(Map<String, dynamic> json) {
  return SupportItemBean(
    json['associatedScenariosType'] as int,
    json['contextType'] as int,
    json['createdAt'] as String,
    json['createdBy'] as String,
    json['helpCateId'] as int,
    json['id'] as int,
    json['isDelete'] as int,
    json['sort'] as int,
    json['status'] as int,
    json['supportType'] as String,
    json['title'] as String,
    json['updatedAt'] as String,
    json['updatedBy'] as String,
  );
}

Map<String, dynamic> _$SupportItemBeanToJson(SupportItemBean instance) =>
    <String, dynamic>{
      'associatedScenariosType': instance.associatedScenariosType,
      'contextType': instance.contextType,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'helpCateId': instance.helpCateId,
      'id': instance.id,
      'isDelete': instance.isDelete,
      'sort': instance.sort,
      'status': instance.status,
      'supportType': instance.supportType,
      'title': instance.title,
      'updatedAt': instance.updatedAt,
      'updatedBy': instance.updatedBy,
    };
