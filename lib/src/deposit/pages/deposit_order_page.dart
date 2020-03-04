import 'dart:async';

import 'package:bw_res/bw_res.dart';
import 'package:bw_sponsor_preferential/bw_sponsor_preferential.dart';
import 'package:bw_sponsor_preferential/src/deposit/model/deposit_pay_entity.dart';
import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:bw_sponsor_preferential/src/widgets/simple_imageview.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DepositOrderPage extends StatefulWidget {
  DepositOrderPage({Key key, this.arguments}) : super(key: key);
  final arguments;
  static const String KEY_DATA = "key_data";

  @override
  _DepositOrderPageState createState() {
    return _DepositOrderPageState();
  }
}

class _DepositOrderPageState extends State<DepositOrderPage> {
  bool isShowBankView = false;
  int money = 998;
  PayBean _data;
  RefreshController _refreshController = RefreshController();
  Stream<int> _streamCountDown;

  StreamController<String> _streamTime = new StreamController.broadcast();

  // 解析路由数据
  void _initArguments() {
    if (widget.arguments != null) {
      _data = widget.arguments[DepositOrderPage.KEY_DATA];
    }
  }

  //获取倒计时时间
  String _getountDownTxt(int seconds) {
    int minute = (seconds / 60).floor();
    int second = seconds % 60; /*存在取余运算*/
    return "$minute:$second";
  }

  @override
  void initState() {
    super.initState();
    _initArguments();
    _addICountDownListener();
  }

  //倒计时
  void _addICountDownListener() {
    _streamCountDown =
        Stream<int>.periodic(Duration(seconds: int.parse(_data.expierTime)));
    _streamCountDown.listen((data) {
      print("===data=====$data");
      _getountDownTxt(int.parse(_data.expierTime) - data);
      _streamTime.sink.add(_getountDownTxt(int.parse(_data.expierTime) - data));
    }, onError: (error) {
      print("流发生错误");
    }, onDone: () {
      print("流已完成");
    }, cancelOnError: false);
  }

  @override
  void dispose() {
    super.dispose();
    _streamTime.close();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
      onRefresh: () => _ss(),
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
                  text: "${_data.amount}",
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
                          .pushNamed(Routes.customerService),
                      child: Text(' 联系客服 ',
                          style: TextStyle(
                              fontSize: 12, color: BWColors.depOrdColor))),
                  Text('确认',
                      style: TextStyle(
                          fontSize: 12, color: BWColors.depOrdDesTxt)),
                ],
              ),
            ),
            if (_data.trnasfer == "0")
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
                          Text(_data.payTypeName ?? "",
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
                          Text('订单号码',style: TextStyle(
                              fontSize: 14, color: BWColors.depOrdDesTxt)),
                          Expanded(
                              child: Text('${_data.billNo}',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: BWColors.depOrdValueTxt))),
                          IconButton(
                            iconSize: 12,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              //todo
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
            if (_data.trnasfer == "1")
              Card(
                color: Colors.white,
                margin: EdgeInsets.all(14),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top:20,bottom: 34 ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SimpleImageView.display(_data.icon,
                              width: 24, height: 24),
                          Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: Text('${_data.bankName}',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold,color: BWColors.depInput)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: <Widget>[
                            Text('姓名：',style: TextStyle(
                                fontSize: 14, color: BWColors.depOrdDesTxt)),
                            Expanded(child: Text('${_data.recipientName}',style: TextStyle(fontSize: 12,color: BWColors.depOrdValueTxt),)),
                            Container(
                              width: 34,
                              height: 15,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: BWColors.depOrdColor),
                              ),
                              child: Text('复制',style: TextStyle(fontSize: 12,color: BWColors.depOrdColor,height: 1),),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Text('金额：',style: TextStyle(
                                fontSize: 14, color: BWColors.depOrdDesTxt)),
                            Expanded(child: Text('${_data.amount}元',style: TextStyle(fontSize: 12,color: BWColors.depOrdValueTxt))),
                            Container(
                              width: 34,
                              height: 15,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: BWColors.depOrdColor),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Text('复制',style: TextStyle(fontSize: 12,color: BWColors.depOrdColor,height: 1),),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '(转账金额务必于订单金额一致)',
                        style: TextStyle(fontSize: 12, color: BWColors.depError),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Text('地址：',style: TextStyle(
                                fontSize: 14, color: BWColors.depOrdDesTxt)),
                            Expanded(child: Text('${_data.recipientAddress}',style: TextStyle(fontSize: 12,color: BWColors.depOrdValueTxt))),
                            Container(
                              width: 34,
                              height: 15,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: BWColors.depOrdColor),
                              ),
                              child: Text('复制',style: TextStyle(fontSize: 12,color: BWColors.depOrdColor,height: 1),),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Text('附言/备注：',style: TextStyle(
                                fontSize: 14, color: BWColors.depOrdDesTxt)),
                            Expanded(child: Text('${_data.remark}',style: TextStyle(fontSize: 12,color: BWColors.depOrdValueTxt))),
                            Container(
                              width: 34,
                              height: 15,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                border: Border.all(color: BWColors.depOrdColor),
                              ),
                              child: Text('复制',style: TextStyle(fontSize: 12,color: BWColors.depOrdColor,height: 1),),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '((请务必填写正确的附言/备注))',
                        style: TextStyle(fontSize: 12, color: BWColors.depError),
                      ),
                    ],
                  ),
                ),
              ),
            if (_data.trnasfer == "1")
              Card(
              color: Colors.white,
              margin: EdgeInsets.all(14),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('重要提醒',style: TextStyle(fontSize: 14,color: BWColors.depOrdValueTxt),),
                    Text('1.转账金额须与订单金额一致，否则存款无法及时到账',style: TextStyle(fontSize: 12,color: BWColors.depOrdDesTxt,height: 1.4),),
                    Text('2.转账必须填写正确附言（备注），否则存款无法及时到账',style: TextStyle(fontSize: 12,color: BWColors.depOrdDesTxt,height: 1.4),),
                    Text('3.下次存款时，请获取新的账号，存入旧账号将无法到账',style: TextStyle(fontSize: 12,color: BWColors.depOrdDesTxt,height: 1.4),),
                    Text('4.请及时前往存款，附言（备注）有效时间只有15分钟',style: TextStyle(fontSize: 12,color: BWColors.depOrdDesTxt,height: 1.4),),
                    Text('5.请勿使用支付宝、微信转账至公司账户',style: TextStyle(fontSize: 12,color: BWColors.depOrdDesTxt,height: 1.4),),
                    Text('6.若存款存在疑问，请及时联系客服',style: TextStyle(fontSize: 12,color: BWColors.depOrdDesTxt,height: 1.4),),
                    Text('7.不知如何存款，请移步至 存款教程',style: TextStyle(fontSize: 12,color: BWColors.depOrdDesTxt,height: 1.4),),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6,bottom: 40),
              child: Text('取消存款申请'),
            ),
          ],
        ),
      ),
    );
  }

  _ss() {}
}
