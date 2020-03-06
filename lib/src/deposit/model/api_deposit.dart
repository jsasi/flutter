import 'package:bw_sponsor_preferential/src/deposit/model/dep_dis_entity.dart';
import 'package:bw_sponsor_preferential/src/deposit/model/deposit_notice_entity.dart';
import 'package:bw_sponsor_preferential/src/deposit/model/deposit_pay_entity.dart';
import 'package:bw_sponsor_preferential/src/deposit/model/deposit_pay_type_entity.dart';
import 'package:bw_sponsor_preferential/src/deposit/model/deposit_unfinished_entity.dart';
import 'package:biz_network_main/biz_network_main.dart';
import 'package:bw_utils/bw_utils.dart';
import 'package:flutter/cupertino.dart';

class ApiDeposit {
  ///   存款校验是否开启支持多订单开关 状态
  static const String _DEPOSIT_LASTUNFINISHED =
      "/api/site/finance/payment/v1/lastUnfinished";

 ///支付方式
  static const String _DEPOSIT_PAY_WAY = "/api/site/finance/payment/v1/types";

  ///存款
  static const String _DEPOSIT_PAY = "/api/site/finance/payment/v1/pay";

  /// 用户关闭存款
  static const String _DEPOSIT_CANCEL = "/api/site/finance/payment/v1/closeOrder";

   ///存款优惠列表 VIP 等级 及 优惠 百分比 对照表
  static const String _DEPOSITE_DISCOUNT = "/api/site/finance/depositDiscount/v1/getDiscountListByType" ;

  ///公告列表
  static const String _DEPOSITE_NOTICE_LIST = "/api/site/group/operation/baseOperation/v1/queryNoticeList";



  /// 获取支付方式
  static Future<DepositPayTypeEntity> getPayTypeList() async {
    var response = await mainClient.dio.post(
      _DEPOSIT_PAY_WAY,
      data: {}
    );
    return DepositPayTypeEntity.fromJson(response.data);
  }
  /// 存款校验是否开启支持多订单开关
  static Future<DepositUnfinishedEntity> getLastUnfinished() async {
    var response = await mainClient.dio.post(
      _DEPOSIT_LASTUNFINISHED,
      data: {}
    );
    return DepositUnfinishedEntity.fromJson(response.data);
  }

  /// 存款
  static Future<DepositPayEntity> loadPayment(int payAmt,String payType,{String depositName,String remark,String bankCode}) async {
    var data= {
      "payAmt":payAmt,
    "payType":payType,
    "remark":remark??"",
    };
    if(StringUtil.isNullOrEmpty(depositName)){
      data["depositName"]=depositName;
    }
    var response = await mainClient.dio.post(
        _DEPOSIT_PAY,
        data:data
    );
    print('========loadPayment=======$response');
    return DepositPayEntity.fromJson(response.data);
  }

  /// 取消订单
  static Future<BaseEntity> cancelOrder(String id) async {
    var response = await mainClient.dio.post(
        _DEPOSIT_CANCEL,
        data: {"id":id}
    );
    return BaseEntity.fromJson(response.data);
  }
  /// 存款优惠列表
  static Future<DepDisEntity> getDepositDicList(String type) async {
    var response = await mainClient.dio.post(
        _DEPOSITE_DISCOUNT,
        data: {"payType":type}
    );
    return DepDisEntity.fromJson(response.data);
  }

  /// 获取公告
  static Future<DepNoticeEntity> getNoticeList() async {
    var response = await mainClient.dio.post(
        _DEPOSITE_NOTICE_LIST,
        data: {"category":3}
    );
    print('=======获取公告=====$response');
    return DepNoticeEntity.fromJson(response.data);
  }
}
