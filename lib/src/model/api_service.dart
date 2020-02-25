import 'package:biz_network_main/biz_network_main.dart';
import 'package:bw_sponsor_preferential/src/model/discount_entity.dart';
import 'package:bw_sponsor_preferential/src/model/service_entity.dart';
import 'package:bw_sponsor_preferential/src/model/sponsor_entity.dart';
import 'package:bw_sponsor_preferential/src/model/support_type_entity.dart';

class ApiService {
  /// 帮助中心列表
  static const String _SSERVICE_HELP_LIST_URL =
      "/api/site/group/site/siteBaseHelp/v1/querySiteHelpCateList";

  /// 帮助中心分类
  static const String _QUERYSITEHELPINFOLIST =
      "/api/site/group/site/siteBaseHelp/v1/querySiteHelpInfoList";

  /// 问题详情
  static const String _HELPCENTERQUESTIONDETAILS =
      "/api/site/group/site/siteBaseHelp/v1/getSiteHelpInfoById";

  /// 优惠列表
  static const String _DISCONNT_LIST_URL =
      "/api/site/group/operation/operationActivityInfo/v1/queryOperationActivityInfoList";

  ///赞助列表
  static const String _SPONSOR_LIST =
      "/api/site/group/operation/baseOperation/v1/queryOperationSponsoredConfigList";

  /// 获取优惠列表
  /// [pageNum] 分页
  static Future<DiscountEntity> getDisList({int pageNum = 1}) async {
    var response = await mainClient.dio.post(
      _DISCONNT_LIST_URL,
      data: {
        "pageNum": pageNum,
        "pageSize": 15,
      },
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
    );
    return SponsorEntity.fromJson(response.data);
  }

  /// 获取客服帮助列表Help
  static Future<ServiceEntity> getSerHelpList() async {
    var response = await mainClient.dio.post(
      _SSERVICE_HELP_LIST_URL,
    );

    return ServiceEntity.fromJson(response.data);
  }

  /// 获取客服分类列表Help
  /// [helpCateId]分类id
  static Future<SupportTypeEntity> getSupTypeList(int helpCateId) async {
    var response = await mainClient.dio
        .post(_QUERYSITEHELPINFOLIST, data: {"helpCateId": helpCateId});
    return SupportTypeEntity.fromJson(response.data);
  }
}
