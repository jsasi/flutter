// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscountEntity _$DiscountEntityFromJson(Map<String, dynamic> json) {
  return DiscountEntity(
    msg: json['msg'],
    code: json['code'],
    errorSn: json['errorSn'],
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DiscountEntityToJson(DiscountEntity instance) =>
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
            : DiscountItemBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['navigateFirstPage'] as int,
    json['navigateLastPage'] as int,
    json['navigatePages'] as int,
    (json['navigatepageNums'] as List)?.map((e) => e as int)?.toList(),
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
      'navigatepageNums': instance.navigatepageNums,
      'nextPage': instance.nextPage,
      'pageNum': instance.pageNum,
      'pageSize': instance.pageSize,
      'pages': instance.pages,
      'prePage': instance.prePage,
      'size': instance.size,
      'startRow': instance.startRow,
      'total': instance.total,
    };

DiscountItemBean _$DiscountItemBeanFromJson(Map<String, dynamic> json) {
  return DiscountItemBean(
    json['activityEndTime'] as String,
    json['activityListPicture'] as String,
    json['activityMoney'] as String,
    json['activityStartTime'] as String,
    json['activityTag'] as String,
    json['activityVenues'] as String,
    json['appDetail'] as String,
    json['appListPicture'] as String,
    json['appTagPicture'] as String,
    json['appTopicLink'] as String,
    json['contentForm'] as int,
    json['countCycle'] as int,
    json['createdAt'] as String,
    json['createdBy'] as String,
    json['cycle'] as int,
    json['displayEndTime'] as String,
    json['displayForm'] as String,
    json['displayStartTime'] as String,
    json['donationMaxMoney'] as String,
    json['donationRatio'] as String,
    (json['effectiveOdds'] as num)?.toDouble(),
    json['flowRequirements'] as String,
    json['h5MainPicture'] as String,
    (json['hkOdds'] as num)?.toDouble(),
    json['id'] as int,
    json['ifOdds'] as int,
    json['isDelete'] as int,
    json['isPermanent'] as int,
    json['levelRequirement'] as String,
    json['participation'] as int,
    json['redemptionPeriod'] as int,
    json['sharePicture'] as String,
    json['sort'] as int,
    json['specialDiscount'] as int,
    json['status'] as int,
    json['supportClient'] as int,
    json['title'] as String,
    json['type'] as int,
    json['updatedAt'] as String,
    json['updatedBy'] as String,
    json['webBackgroundPicture'] as String,
    json['webDetail'] as String,
    json['webListPicture'] as String,
    json['webMainPicture'] as String,
    json['webTopicLink'] as String,
  );
}

Map<String, dynamic> _$DiscountItemBeanToJson(DiscountItemBean instance) =>
    <String, dynamic>{
      'activityEndTime': instance.activityEndTime,
      'activityListPicture': instance.activityListPicture,
      'activityMoney': instance.activityMoney,
      'activityStartTime': instance.activityStartTime,
      'activityTag': instance.activityTag,
      'activityVenues': instance.activityVenues,
      'appDetail': instance.appDetail,
      'appListPicture': instance.appListPicture,
      'appTagPicture': instance.appTagPicture,
      'appTopicLink': instance.appTopicLink,
      'contentForm': instance.contentForm,
      'countCycle': instance.countCycle,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'cycle': instance.cycle,
      'displayEndTime': instance.displayEndTime,
      'displayForm': instance.displayForm,
      'displayStartTime': instance.displayStartTime,
      'donationMaxMoney': instance.donationMaxMoney,
      'donationRatio': instance.donationRatio,
      'effectiveOdds': instance.effectiveOdds,
      'flowRequirements': instance.flowRequirements,
      'h5MainPicture': instance.h5MainPicture,
      'hkOdds': instance.hkOdds,
      'id': instance.id,
      'ifOdds': instance.ifOdds,
      'isDelete': instance.isDelete,
      'isPermanent': instance.isPermanent,
      'levelRequirement': instance.levelRequirement,
      'participation': instance.participation,
      'redemptionPeriod': instance.redemptionPeriod,
      'sharePicture': instance.sharePicture,
      'sort': instance.sort,
      'specialDiscount': instance.specialDiscount,
      'status': instance.status,
      'supportClient': instance.supportClient,
      'title': instance.title,
      'type': instance.type,
      'updatedAt': instance.updatedAt,
      'updatedBy': instance.updatedBy,
      'webBackgroundPicture': instance.webBackgroundPicture,
      'webDetail': instance.webDetail,
      'webListPicture': instance.webListPicture,
      'webMainPicture': instance.webMainPicture,
      'webTopicLink': instance.webTopicLink,
    };
