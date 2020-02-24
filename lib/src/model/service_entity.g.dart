// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceEntity _$ServiceEntityFromJson(Map<String, dynamic> json) {
  return ServiceEntity(
    msg: json['msg'],
    code: json['code'],
    errorSn: json['errorSn'],
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ServiceItemBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ServiceEntityToJson(ServiceEntity instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'errorSn': instance.errorSn,
      'data': instance.data,
    };

ServiceItemBean _$ServiceItemBeanFromJson(Map<String, dynamic> json) {
  return ServiceItemBean(
    json['createdAt'] as String,
    json['createdBy'] as String,
    json['iconUrl'] as String,
    json['id'] as int,
    json['isDelete'] as int,
    json['name'] as String,
    json['shortTitle'] as String,
    json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$ServiceItemBeanToJson(ServiceItemBean instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'iconUrl': instance.iconUrl,
      'id': instance.id,
      'isDelete': instance.isDelete,
      'name': instance.name,
      'shortTitle': instance.shortTitle,
      'updatedAt': instance.updatedAt,
    };
