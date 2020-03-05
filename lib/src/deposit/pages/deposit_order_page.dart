import 'dart:async';
import 'package:biz_network_main/biz_network_main.dart';
import 'package:bw_base/bw_base.dart';
import 'package:bw_res/bw_res.dart';
import 'package:bw_sponsor_preferential/bw_sponsor_preferential.dart';
import 'package:bw_sponsor_preferential/src/deposit/model/api_deposit.dart';
import 'package:bw_sponsor_preferential/src/deposit/model/deposit_pay_entity.dart';
import 'package:bw_sponsor_preferential/src/deposit/model/deposit_unfinished_entity.dart';
import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:bw_sponsor_preferential/src/widgets/simple_imageview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DepositOrderPage extends StatefulWidget {
  DepositOrderPage({Key key, this.data}) : super(key: key);
  final   PayBean data;

  @override
  _DepositOrderPageState createState() {
    return _DepositOrderPageState();
  }
}

class _DepositOrderPageState extends State<DepositOrderPage> {
  bool isShowBankView = false;

  RefreshController _refreshController = RefreshController();

  StreamController<String> _streamTime = new StreamController.broadcast();
  StreamSubscription _streamSubscription;


  //获取订单状态
  void _getLastUnfinished() async {
    var entity = await ApiDeposit.getLastUnfinished();
    if (entity.code == 0 && entity.data != null) {
      DepositUnfinishedBean bean = entity.data;
      if (bean.records == null) {
        Navigator.pop(context);
      } else {
        //显示订单的状态
        var showDetailsPayStatus =
            bean.records.payStatus == 1 || bean.records.payStatus == 4;
        //是否是当前有效订单
        var isCurrentValidOrider = widget.data.bankName == bean.records.billNo;
        //是否是单笔订单
        var isSingOrder = bean.moreSwitch == "1";
        if (showDetailsPayStatus && (isSingOrder || isCurrentValidOrider)) {
          setState(() {
            widget.data.trnasfer = bean.transfer;
            widget.data.alert = null;
            widget.data.amount = bean.records.orderAmount;
            widget.data.billNo = bean.records.billNo;
            widget.data.expierTime = bean.expireTime;
            widget.data.id = bean.records.id;
            widget.data.payTypeName = bean.payTypeName;
            widget.data.qrUrl = bean.records.qrUrl;
            widget.data.recipientAccount = bean.records.recipientAccount;
            widget.data.recipientAddress = bean.records.recipientAddress;
            widget.data.recipientBank = bean.records.recipientBank;
            widget.data.bankName = bean.bankName;
            widget.data.recipientName = bean.records.recipientName;
            widget.data.icon = bean.icon;
            widget.data.remark = bean.records.recipientCode;
            widget.data.payStatus = bean.records.payStatus;
            _refreshController.refreshCompleted();
          });
        } else {
          Navigator.pop(context);
        }
      }
    } else {
      _refreshController.refreshFailed();
    }
  }

  //获取倒计时时间
  String _getountDownTxt(int seconds) {
    int minute = (seconds / 60).floor();
    String second = (seconds % 60).toString(); /*存在取余运算*/
    if (second.toString().length == 1) {
      second = "0$second";
    }
    return "$minute:$second";
  }

  _refresh() {
    _getLastUnfinished();
  }

  @override
  void initState() {
    super.initState();
  }

  //倒计时
  void _addICountDownListener() {
    _streamSubscription?.cancel();
    Stream<int> _streamCountDown =
        Stream<int>.periodic(Duration(seconds: 1), (data) => data);
    _streamCountDown.take(int.parse(widget.data.expierTime));
    _streamSubscription = _streamCountDown.listen(
        (data) {
          _getountDownTxt(int.parse(widget.data.expierTime) - data);
          _streamTime.sink
              .add(_getountDownTxt(int.parse(widget.data.expierTime) - data));
        },
        onError: (error) {},
        onDone: () {
          _getLastUnfinished();
        },
        cancelOnError: false);
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription?.cancel();
    _streamTime.close();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _addICountDownListener();
    return Scaffold(
      appBar: DssAppBar(
        '存款信息',
        hideLeftArrow: false,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    double width = MediaQuery.of(context).size.width;
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      onRefresh: () => _refresh(),
      controller: _refreshController,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: width,
              padding: EdgeInsets.only(top: 22),
              color: Colors.white,
              child: Text.rich(TextSpan(
                  text: "${widget.data.amount}",
                  style: TextStyle(fontSize: 32, color: BWColors.depOrdMoney),
                  children: <TextSpan>[
                    TextSpan(
                      text: "元",
                      style:
                          TextStyle(fontSize: 14, color: BWColors.depOrdMoney),
                    ),
                  ])),
            ),
            StreamBuilder<String>(
                stream: _streamTime.stream,
                initialData: _getountDownTxt(1800),
                builder: (context, snapshot) {
                  return Container(
                    alignment: Alignment.center,
                    width: width,
                    padding: EdgeInsets.only(top: 12),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '请在',
                          style: TextStyle(
                              fontSize: 12, color: BWColors.depOrdDesTxt),
                        ),
                        Text('${snapshot.data}',
                            style: TextStyle(
                                fontSize: 12, color: BWColors.depOrdCountDown)),
                        Text(
                          '内完成支付',
                          style: TextStyle(
                              fontSize: 12, color: BWColors.depOrdDesTxt),
                        ),
                      ],
                    ),
                  );
                }),
            Container(
              alignment: Alignment.center,
              width: width,
              padding: EdgeInsets.only(top: 11, bottom: 18),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('如已完成支付，请',
                      style: TextStyle(
                          fontSize: 12, color: BWColors.depOrdDesTxt)),
                  InkWell(
                      onTap: () => Navigator.of(context)
                          .pushNamed(BwSpRoutes.customerService),
                      child: Text(' 联系客服 ',
                          style: TextStyle(
                              fontSize: 12, color: BWColors.depOrdColor))),
                  Text('确认',
                      style: TextStyle(
                          fontSize: 12, color: BWColors.depOrdDesTxt)),
                ],
              ),
            ),
            if (widget.data.trnasfer == "0")
              Card(
                color: Colors.white,
                margin: EdgeInsets.all(14),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 12, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('存款方式',
                              style: TextStyle(
                                  fontSize: 14, color: BWColors.depOrdDesTxt)),
                          Text(widget.data.payTypeName ?? "",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: BWColors.depOrdValueTxt)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15, left: 12, right: 12, bottom: 15),
                      child: Row(
                        children: <Widget>[
                          Text('订单号码',
                              style: TextStyle(
                                  fontSize: 14, color: BWColors.depOrdDesTxt)),
                          Expanded(
                              child: Text('${widget.data.billNo}',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: BWColors.depOrdValueTxt))),
                          IconButton(
                            iconSize: 12,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: '${widget.data.billNo}'));
                            },
                            icon: Icon(
                              Icons.content_copy,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            if (widget.data.trnasfer == "1")
              Card(
                color: Colors.white,
                margin: EdgeInsets.all(14),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 34),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SimpleImageView.display(widget.data.icon,
                              width: 24, height: 24),
                          Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: Text('${widget.data.bankName}',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: BWColors.depInput)),
                          ),
                        ],
                      ),
                      _buildItem('姓名：','${widget.data.recipientName}'),
                      _buildItem('金额：','${widget.data.amount}元'),
                      Text(
                        '(转账金额务必于订单金额一致)',
                        style:
                            TextStyle(fontSize: 12, color: BWColors.depError),
                      ),
                      _buildItem('地址：','${widget.data.recipientAddress}'),
                      _buildItem('附言/备注：','${widget.data.remark}'),
                      Text(
                        '((请务必填写正确的附言/备注))',
                        style:
                            TextStyle(fontSize: 12, color: BWColors.depError),
                      ),
                    ],
                  ),
                ),
              ),
            if (widget.data.trnasfer == "1")
              Card(
                color: Colors.white,
                margin: EdgeInsets.all(14),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '重要提醒',
                        style: TextStyle(
                            fontSize: 14, color: BWColors.depOrdValueTxt),
                      ),
                      Text(
                        '1.转账金额须与订单金额一致，否则存款无法及时到账',
                        style: TextStyle(
                            fontSize: 12,
                            color: BWColors.depOrdDesTxt,
                            height: 1.4),
                      ),
                      Text(
                        '2.转账必须填写正确附言（备注），否则存款无法及时到账',
                        style: TextStyle(
                            fontSize: 12,
                            color: BWColors.depOrdDesTxt,
                            height: 1.4),
                      ),
                      Text(
                        '3.下次存款时，请获取新的账号，存入旧账号将无法到账',
                        style: TextStyle(
                            fontSize: 12,
                            color: BWColors.depOrdDesTxt,
                            height: 1.4),
                      ),
                      Text(
                        '4.请及时前往存款，附言（备注）有效时间只有15分钟',
                        style: TextStyle(
                            fontSize: 12,
                            color: BWColors.depOrdDesTxt,
                            height: 1.4),
                      ),
                      Text(
                        '5.请勿使用支付宝、微信转账至公司账户',
                        style: TextStyle(
                            fontSize: 12,
                            color: BWColors.depOrdDesTxt,
                            height: 1.4),
                      ),
                      Text(
                        '6.若存款存在疑问，请及时联系客服',
                        style: TextStyle(
                            fontSize: 12,
                            color: BWColors.depOrdDesTxt,
                            height: 1.4),
                      ),
                      Text(
                        '7.不知如何存款，请移步至 存款教程',
                        style: TextStyle(
                            fontSize: 12,
                            color: BWColors.depOrdDesTxt,
                            height: 1.4),
                      ),
                    ],
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 40),
              child: InkWell(
                  onTap: () => _showCancelDialog(), child: Text('取消存款申请')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String key,String value) {
    return Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: <Widget>[
                          Text(key,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: BWColors.depOrdDesTxt)),
                          Expanded(
                              child: Text(
                                value,
                            style: TextStyle(
                                fontSize: 12, color: BWColors.depOrdValueTxt),
                          )),
                          Container(
                            width: 34,
                            height: 15,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              border: Border.all(color: BWColors.depOrdColor),
                            ),
                            child: InkWell(
                              onTap: ()=>Clipboard.setData(ClipboardData(text: value)),
                              child: Text(
                                '复制',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: BWColors.depOrdColor,
                                    height: 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
  }

  _showCancelDialog() {
    showDialog<bool>(
      context: context,
      builder: (context) {
        return BwDialog(
          title: "是否取消本次申请",
          textContent: "如果您已完成转账，请勿取消，我们将尽快为您处理！",
          actions: [
            BwDialogAction(
              text: '我再想想',
            ),
            BwDialogAction(
              text: '确定取消',
              callback: () => {
                Navigator.pop(context),
                _cancelOrder(),
              },
            ),
          ],
        );
      },
    );
  }

  ///取消订单
  _cancelOrder() async {
    BaseEntity entity = await ApiDeposit.cancelOrder(widget.data.id);
    if (entity.code == 0) {
      Navigator.pop(context);
    } else {
      showToast(entity.msg);
    }
  }
}
