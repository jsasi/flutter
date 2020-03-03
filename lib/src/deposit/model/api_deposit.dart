import 'package:bw_sponsor_preferential/src/deposit/model/deposit_pay_type_entity.dart';
import 'package:bw_sponsor_preferential/src/deposit/model/deposit_unfinished_entity.dart';
import 'package:biz_network_main/biz_network_main.dart';

class ApiDeposit {
  ///   存款校验是否开启支持多订单开关 状态
  static const String _DEPOSIT_LASTUNFINISHED =
      "/api/site/finance/payment/v1/lastUnfinished";

 ///支付方式
  static const String _DEPOSIT_PAY_WAY = "/api/site/finance/payment/v1/types";

  /// 获取支付方式
  static Future<DepositPayTypeEntity> getPayTypeList() async {
    var response = await mainClient.dio.post(
      _DEPOSIT_PAY_WAY,
      data: {}
    );
    print('========getPayTypeList=======$response');
    return DepositPayTypeEntity.fromJson(response.data);
  }
  /// 存款校验是否开启支持多订单开关
  static Future<DepositUnfinishedEntity> getLastUnfinished() async {
    var response = await mainClient.dio.post(
      _DEPOSIT_LASTUNFINISHED,
      data: {}
    );
    print('========getLastUnfinished=======$response');
    return DepositUnfinishedEntity.fromJson(response.data);
  }
}
