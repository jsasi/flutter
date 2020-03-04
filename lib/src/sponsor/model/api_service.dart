import 'dart:io';

import 'package:biz_network_main/biz_network_main.dart';
import 'package:bw_base/bw_base.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/discount_entity.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/fee_que_type_entity.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/feedback_add_entity.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/feedback_details_entity.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/feedback_entity.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/multi_upload_entity.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/service_entity.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/sponsor_entity.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/support_details_entity.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/support_type_entity.dart';
import 'package:dio/dio.dart';

class ApiService {
  /// 帮助中心列表
  static const String _SSERVICE_HELP_LIST_URL =
      "/api/site/group/site/siteBaseHelp/v1/querySiteHelpCateList";

  /// 帮助中心分类
  static const String _QUERYSITEHELPINFOLIST =
      "/api/site/group/site/siteBaseHelp/v1/querySiteHelpInfoList";

  /// 问题详情
  static const String _SUPPORTDETAILS =
      "/api/site/group/site/siteBaseHelp/v1/getSiteHelpInfoById";

  /// 优惠列表
  static const String _DISCONNT_LIST_URL =
      "/api/site/group/operation/operationActivityInfo/v1/queryOperationActivityInfoList";

  ///赞助列表
  static const String _SPONSOR_LIST =
      "/api/site/group/operation/baseOperation/v1/queryOperationSponsoredConfigList";

  ///意见反馈列表
  static const String _FEEDBACK_LIST =
      "/api/site/group/member/commentFeedback/v1/queryCommentFeedbackList";

  /// 意见反馈问题列表
  static const String _FEED_TYPE = "/api/component/dict/dictType/v1/query";
  static const String _DICT_CODE = "custom_feedback";

  /// 意见反馈问题提交
  static const String _FEED_COMMIT =
      "/api/site/group/member/commentFeedback/v1/insertCommentFeedback";

  /// 意见反馈详情
  static const String _FEED_DETAILS =
      "/api/site/group/member/commentFeedback/v1/getCommentFeedbackById";

  /// 删除意见反馈
  static const String _FEED_DEL =
      "/api/site/group/member/commentFeedback/v1/deleteByPrimaryKey";

  ///意见反馈上传多个文件
  static const String _FEED_UPLOAD_FILE =
      "/api/component/memberfile/staticSource/v1/uploadMulti";

  /// 获取优惠列表
  /// [pageNum] 分页
  static Future<DiscountEntity> getDisList({int pageNum = 1}) async {
    var response = await mainClient.dio.post(
      _DISCONNT_LIST_URL,
      data: {
        "pageNum": pageNum,
        "pageSize": 15,
      },
      options: Options(extra: BwManager.noneToken),
    );

    return DiscountEntity.fromJson(response.data);
  }

  /// 获取赞助列表
  /// [pageNum] 分页
  static Future<SponsorEntity> getSpoList({int pageNum = 1}) async {
    var response = await mainClient.dio.post(
      _SPONSOR_LIST,
      data: {
        "pageNum": pageNum,
        "pageSize": 15,
      },
      options: Options(extra: BwManager.noneToken),
    );
    return SponsorEntity.fromJson(response.data);
  }

  /// 获取客服帮助列表Help
  static Future<ServiceEntity> getSerHelpList() async {
    var response = await mainClient.dio.post(
      _SSERVICE_HELP_LIST_URL,
      options: Options(extra: BwManager.noneToken),
    );

    return ServiceEntity.fromJson(response.data);
  }

  /// 获取客服分类列表Help
  /// [helpCateId]分类id
  static Future<SupportTypeEntity> getSupTypeList(int helpCateId) async {
    var response = await mainClient.dio.post(
      _QUERYSITEHELPINFOLIST,
      data: {"helpCateId": helpCateId},
      options: Options(extra: BwManager.noneToken),
    );
    return SupportTypeEntity.fromJson(response.data);
  }

  /// 获取客服问题详情
  /// [id]问题id
  static Future<SupportDetailsEntity> getSupDetailsInfo(int id) async {
    var response = await mainClient.dio.post(
      _SUPPORTDETAILS,
      data: {"id": id},
      options: Options(extra: BwManager.noneToken),
    );
    return SupportDetailsEntity.fromJson(response.data);
  }

  /// 意见反馈分类列表
  static Future<FeeQueTypeEntity> getFeeTypeList() async {
    var response =
        await mainClient.dio.post(_FEED_TYPE, data: {"dictCode": _DICT_CODE});
    return FeeQueTypeEntity.fromJson(response.data);
  }

  /// 意见反馈上传图片
  static Future<MultiUploadEntity> uploadFeeFiles(List<File> files) async {
    var multipartFiles = files.map((file) {
      return MapEntry(
        "files",
        MultipartFile.fromFileSync(file.path),
      );
    }).toList();
    var formData = FormData();
    formData.files.addAll(multipartFiles);
    var response = await mainClient.dio.post(
      _FEED_UPLOAD_FILE,
      data: formData,
      options: Options()..contentType = 'multipart/form-data;',
    );
    return MultiUploadEntity.fromJson(response.data);
  }

  /// 新增意见反馈
  static Future<FeedbackAddEntity> addFeeback(
    String category,
    String description,
    String content,
    String picUrls,
  ) async {
    var data = {
      "category": category,
      "description": description,
      "content": content,
      if (picUrls != null && picUrls.isNotEmpty) "picUrls": picUrls,
    };
    var response = await mainClient.dio.post(_FEED_COMMIT, data: data);
    return FeedbackAddEntity.fromJson(response.data);
  }

  /// 获取反馈列表
  /// [pageNum] 分页
  static Future<FeedbackEntity> getFeedbackList({int pageNum = 1}) async {
    var response = await mainClient.dio.post(
      _FEEDBACK_LIST,
      data: {
        "pageNum": pageNum,
        "pageSize": 15,
      },
    );
    return FeedbackEntity.fromJson(response.data);
  }

  /// 获取反馈详情
  /// [id] 详情id
  static Future<FeedbackDetailsEntity> getFeedbackDetails(int id) async {
    var response = await mainClient.dio.post(
      _FEED_DETAILS,
      data: {
        "id": id,
      },
    );
    return FeedbackDetailsEntity.fromJson(response.data);
  }
}
