// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_notice_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepNoticeEntity _$DepNoticeEntityFromJson(Map<String, dynamic> json) {
  return DepNoticeEntity(
    msg: json['msg'],
    code: json['code'],
    errorSn: json['errorSn'],
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : NoticeEntry.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DepNoticeEntityToJson(DepNoticeEntity instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'errorSn': instance.errorSn,
      'data': instance.data,
    };

NoticeEntry _$NoticeEntryFromJson(Map<String, dynamic> json) {
  return NoticeEntry(
    json['appImage'] as String,
    json['appImageUrl'] as String,
    json['category'] as int,
    json['clients'] as String,
    json['content'] as String,
    json['createdAt'] as String,
    json['createdBy'] as String,
    json['id'] as int,
    json['sysStatus'] as int,
    json['title'] as String,
    json['updatedAt'] as String,
    json['updatedBy'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$NoticeEntryToJson(NoticeEntry instance) =>
    <String, dynamic>{
      'appImage': instance.appImage,
      'appImageUrl': instance.appImageUrl,
      'category': instance.category,
      'clients': instance.clients,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'id': instance.id,
      'sysStatus': instance.sysStatus,
      'title': instance.title,
      'updatedAt': instance.updatedAt,
      'updatedBy': instance.updatedBy,
      'url': instance.url,
    };
