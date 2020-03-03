// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_upload_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiUploadEntity _$MultiUploadEntityFromJson(Map<String, dynamic> json) {
  return MultiUploadEntity(
    msg: json['msg'],
    code: json['code'],
    errorSn: json['errorSn'],
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : UploadBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MultiUploadEntityToJson(MultiUploadEntity instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'errorSn': instance.errorSn,
      'data': instance.data,
    };

UploadBean _$UploadBeanFromJson(Map<String, dynamic> json) {
  return UploadBean(
    json['contentType'] as String,
    json['fileId'] as String,
    json['fileName'] as String,
    json['fileUrl'] as String,
    json['lastModified'] as int,
    json['size'] as int,
  );
}

Map<String, dynamic> _$UploadBeanToJson(UploadBean instance) =>
    <String, dynamic>{
      'contentType': instance.contentType,
      'fileId': instance.fileId,
      'fileName': instance.fileName,
      'fileUrl': instance.fileUrl,
      'lastModified': instance.lastModified,
      'size': instance.size,
    };
