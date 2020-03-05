import 'package:bw_sponsor_preferential/src/common/page_status.dart';
import 'package:bw_sponsor_preferential/src/deposit/model/api_deposit.dart';
import 'package:bw_sponsor_preferential/src/deposit/model/deposit_pay_entity.dart';
import 'package:bw_sponsor_preferential/src/deposit/model/deposit_pay_type_entity.dart';
import 'package:bw_sponsor_preferential/src/deposit/model/deposit_unfinished_entity.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/api_service.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/discount_entity.dart';
import 'package:flutter/material.dart';

class DepositModel extends ChangeNotifier {
  ScreenStatus _screenStatus = ScreenStatus.Loading;

  ScreenStatus get screenStatus => _screenStatus;
  PayBean _payBean;
  PayBean get payBean => _payBean; //支付方式
  List<TypeEntryBean> _typeList = List();

  List<TypeEntryBean> get typeList => _typeList;

  DepositModel();

  //true 显示订单页，false显示存款
  bool _isShowOrder = true;

  bool get isShowOrder => _isShowOrder;


  String _billNumber = "_1.1";

  //支付方式列表获取
  Future getPayTypeList() async {
    var entity = await ApiDeposit.getPayTypeList();
    if (entity.code == 0 && entity.data?.typeList?.isNotEmpty == true) {
      _typeList = entity.data.typeList;
      _screenStatus = ScreenStatus.LoadSuccess;
    } else {
      _screenStatus = ScreenStatus.Error;
    }
  }

  //多订单 moreSwitch: 0-是 1-否
  void getLastUnfinished() async {
    var entity = await ApiDeposit.getLastUnfinished();
    if (entity.code == 0 && entity.data != null) {
      DepositUnfinishedBean bean = entity.data;
      if (bean.records == null) {
        //显示存款页
        _isShowOrder = false;
        await getPayTypeList();
      } else {
        //显示订单的状态
        var showDetailsPayStatus =
            bean.records.payStatus == 1 || bean.records.payStatus == 4;
        //是否是当前有效订单
        var isCurrentValidOrider =
            _billNumber == bean.records.billNo;
        //是否是单笔订单
        var isSingOrder = bean.moreSwitch == "1";
        if (showDetailsPayStatus && (isSingOrder || isCurrentValidOrider)) {
          _payBean=_transformEntry(bean);
          //显示订单详情页
          _isShowOrder = true;
          _billNumber = bean.records.billNo;
          _screenStatus = ScreenStatus.LoadSuccess;
        } else {
          //显示存款页
          _isShowOrder = false;
          await getPayTypeList();
        }
      }
    } else {
      //显示缺省页
      _screenStatus = ScreenStatus.Error;
    }
    notifyListeners();
  }

  PayBean _transformEntry(DepositUnfinishedBean bean) {
    PayBean data = PayBean();
    data.trnasfer = bean.transfer;
    data.alert = null;
    data.amount = bean.records.orderAmount;
    data.billNo = bean.records.billNo;
    data.expierTime = bean.expireTime;
    data.id = bean.records.id;
    data.payTypeName = bean.payTypeName;
    data.qrUrl = bean.records.qrUrl;
    data.recipientAccount = bean.records.recipientAccount;
    data.recipientAddress = bean.records.recipientAddress;
    data.recipientBank = bean.records.recipientBank;
    data.bankName = bean.bankName;
    data.recipientName = bean.records.recipientName;
    data.icon = bean.icon;
    data.remark = bean.records.recipientCode;
    data.payStatus = bean.records.payStatus;
    return data;
  }

  void init() async {
    _screenStatus = ScreenStatus.Loading;
    getLastUnfinished();
    notifyListeners();
  }
}
