// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsor_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SponsorEntity _$SponsorEntityFromJson(Map<String, dynamic> json) {
  return SponsorEntity(
    msg: json['msg'],
    code: json['code'],
    errorSn: json['errorSn'],
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SponsorEntityToJson(SponsorEntity instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'code': instance.code,
      'errorSn': instance.errorSn,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['endRow'] as int,
    json['hasNextPage'] as bool,
    json['hasPreviousPage'] as bool,
    json['isFirstPage'] as bool,
    json['isLastPage'] as bool,
    (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : SponorItemBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['navigateFirstPage'] as int,
    json['navigateLastPage'] as int,
    json['navigatePages'] as int,
    json['nextPage'] as int,
    json['pageNum'] as int,
    json['pageSize'] as int,
    json['pages'] as int,
    json['prePage'] as int,
    json['size'] as int,
    json['startRow'] as int,
    json['total'] as int,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'endRow': instance.endRow,
      'hasNextPage': instance.hasNextPage,
      'hasPreviousPage': instance.hasPreviousPage,
      'isFirstPage': instance.isFirstPage,
      'isLastPage': instance.isLastPage,
      'list': instance.list,
      'navigateFirstPage': instance.navigateFirstPage,
      'navigateLastPage': instance.navigateLastPage,
      'navigatePages': instance.navigatePages,
      'nextPage': instance.nextPage,
      'pageNum': instance.pageNum,
      'pageSize': instance.pageSize,
      'pages': instance.pages,
      'prePage': instance.prePage,
      'size': instance.size,
      'startRow': instance.startRow,
      'total': instance.total,
    };

SponorItemBean _$SponorItemBeanFromJson(Map<String, dynamic> json) {
  return SponorItemBean(
    json['createdAt'] as String,
    json['createdBy'] as String,
    json['firstCreative'] as String,
    json['id'] as int,
    json['infoUrl'] as String,
    json['isDelete'] as int,
    json['keyCreative'] as String,
    json['secondCreative'] as String,
    json['shareTitle'] as String,
    json['shareUrl'] as String,
    json['showEndTime'] as String,
    json['showStartTime'] as String,
    json['sort'] as int,
    json['sponsoredIconUrl'] as String,
    json['sponsoredTile'] as String,
    json['sponsoredUrl'] as String,
    json['status'] as int,
    json['updatedAt'] as String,
    json['updatedBy'] as String,
  );
}

Map<String, dynamic> _$SponorItemBeanToJson(SponorItemBean instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'firstCreative': instance.firstCreative,
      'id': instance.id,
      'infoUrl': instance.infoUrl,
      'isDelete': instance.isDelete,
      'keyCreative': instance.keyCreative,
      'secondCreative': instance.secondCreative,
      'shareTitle': instance.shareTitle,
      'shareUrl': instance.shareUrl,
      'showEndTime': instance.showEndTime,
      'showStartTime': instance.showStartTime,
      'sort': instance.sort,
      'sponsoredIconUrl': instance.sponsoredIconUrl,
      'sponsoredTile': instance.sponsoredTile,
      'sponsoredUrl': instance.sponsoredUrl,
      'status': instance.status,
      'updatedAt': instance.updatedAt,
      'updatedBy': instance.updatedBy,
    };
