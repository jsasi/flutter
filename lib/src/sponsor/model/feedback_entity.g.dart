// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackEntity _$FeedbackEntityFromJson(Map<String, dynamic> json) {
  return FeedbackEntity(
    msg: json['msg'],
    code: json['code'],
    errorSn: json['errorSn'],
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FeedbackEntityToJson(FeedbackEntity instance) =>
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
            : FeedbackItemBean.fromJson(e as Map<String, dynamic>))
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

FeedbackItemBean _$FeedbackItemBeanFromJson(Map<String, dynamic> json) {
  return FeedbackItemBean(
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

Map<String, dynamic> _$FeedbackItemBeanToJson(FeedbackItemBean instance) =>
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
