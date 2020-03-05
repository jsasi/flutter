import 'dart:async';
import 'dart:math';
import 'package:bw_res/bw_res.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_sponsor_preferential/bw_sponsor_preferential.dart';
import 'package:bw_sponsor_preferential/src/deposit/model/api_deposit.dart';
import 'package:bw_sponsor_preferential/src/deposit/model/dep_dis_entity.dart';
import 'package:bw_sponsor_preferential/src/deposit/model/deposit_pay_entity.dart';
import 'package:bw_sponsor_preferential/src/deposit/model/deposit_pay_type_entity.dart';
import 'package:bw_sponsor_preferential/src/deposit/pages/deposit_discount_dialog.dart';
import 'package:bw_sponsor_preferential/src/widgets/deposit_dis_tip_view.dart';
import 'package:bw_sponsor_preferential/src/widgets/simple_imageview.dart';
import 'package:bw_sponsor_preferential/src/widgets/support_footer_view.dart';
import 'package:bw_utils/bw_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';

/// 存款
class DepositView extends StatefulWidget {
  DepositView(this.data, {Key key}) : super(key: key);

  final List<TypeEntryBean> data;

  @override
  _DepositViewState createState() {
    return _DepositViewState();
  }
}

class _DepositViewState extends State<DepositView> {
  int selTypeIndex = 0;
  int selMoneyIndex = 0;

  //是否展示额外优惠提示
  bool isShowDiscountTip = false;

  //名字输入是否合法
  bool verifyName = false;

  //金额输入是否合法
  bool verifyMoney = true;

  //是否需要键入名字
  bool isRequiredName = false;

  //是否需要键入金额
  bool isRequiredMoney = false;

//提交按钮是否可点击
  bool disabledSubmit = true;

// 优惠列表
  Map<String, List<DepDisBean>> discountCache = Map();

  List<int> moneyList = [];
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _moneyController = new TextEditingController();
  final StreamController<int> _streamNameController =
      StreamController.broadcast();
  final StreamController<int> _streamMoneyController =
      StreamController.broadcast();
  final StreamController<bool> _streamSubmitController =
      StreamController.broadcast();
  final StreamController<bool> _streamShowTipsController =
      StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    _initMoneyList();
    setIsShowDisTip(selTypeIndex);
    _moneyController.addListener(() {
      if (_verifyMoney(_moneyController.text.toString()) != verifyMoney) {
        verifyMoney = _verifyMoney(_moneyController.text.toString());
        _streamMoneyController.sink.add(selMoneyIndex);
      }

      _setSubmitBtnState();
    });
    _nameController.addListener(() {
      verifyName = _verifyName(_nameController.text.toString());
      //改变输入框提示语和错误语显隐
      _streamNameController.sink.add(verifyName ? 0 : 1);
      _setSubmitBtnState();
    });
  }

  @override
  void dispose() {
    _streamNameController.close();
    _streamMoneyController.close();
    _streamSubmitController.close();
    _streamShowTipsController.close();
    _nameController.dispose();
    _moneyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("=======waiceng ==$isShowDiscountTip==");
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Padding(
            padding: EdgeInsets.only(left: 14, top: 10, bottom: 10),
            child: Text(
              Strings.depositPayMethod,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 14, color: BWColors.depTitle),
            ),
          ),
          Divider(
            height: 1,
            color: BWColors.dssDivider,
            indent: 14,
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: widget.data.length,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 79 / 70,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () => {
                        setState(() {
                          selTypeIndex = index;
                          _setSubmitBtnState();
                          isRequiredName =
                              widget.data[selTypeIndex].transfer == "1";
                          setIsShowDisTip(index);
                          _streamShowTipsController.sink.add(isShowDiscountTip);
                          _setSubmitBtnState();
                        }),
                      },
                  child: _buildPayTypeItem(
                      widget.data[index], selTypeIndex == index));
            },
          ),
          if (isRequiredName) _buildNameWidget(),
          Container(
            height: 10,
            color: BWColors.dssDivider,
          ),
          Padding(
            padding: EdgeInsets.only(left: 14, top: 10, bottom: 10),
            child: Text(
              Strings.deposits,
              style: TextStyle(fontSize: 14, color: BWColors.depTitle),
            ),
          ),
          Divider(
            color: BWColors.dssDivider,
            indent: 14,
            height: 1,
          ),
          StreamBuilder<int>(
              stream: _streamMoneyController.stream,
              initialData: selMoneyIndex,
              builder: (context, snapshot) {
                return Column(
                  children: <Widget>[
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: moneyList.length,
                      physics: NeverScrollableScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 79 / 35,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              selMoneyIndex = index;
                              isRequiredMoney =
                                  selMoneyIndex == moneyList.length - 1;
                              _streamMoneyController.sink.add(selMoneyIndex);
                              _setSubmitBtnState();
                              isShowDiscountTip = false;
                              _streamShowTipsController.sink
                                  .add(isShowDiscountTip);
                            },
                            child: _buildMoneyItem(
                                moneyList[index], selMoneyIndex == index));
                      },
                    ),
                    if (isRequiredMoney)
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 14,
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(
                              '¥',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: BWColors.depInput,
                                  fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: TextField(
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter(
                                      RegExp("[0-9]"))
                                ],
                                controller: _moneyController,
                                maxLength: 8,
                                decoration: new InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        fontSize: 20, color: BWColors.dssDesc),
                                    hintText: "请输入存款金额（100-19999）",
                                    suffixIcon: IconButton(
                                      icon: Icon(CupertinoIcons.clear_circled),
                                      iconSize: 12,
                                      onPressed: () => _moneyController.clear(),
                                    )),
                                style: TextStyle(
                                    fontSize: 24, color: BWColors.depInput),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (isRequiredMoney)
                      Divider(
                        height: 1,
                        color: BWColors.dssDivider,
                        indent: 14,
                        endIndent: 16,
                      ),
                    if (isRequiredMoney &&
                        !verifyMoney &&
                        !StringUtil.isNullOrEmpty(
                            _moneyController.text.toString()))
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 14, right: 16),
                        height: 30,
                        child: Text(
                          Strings.depositsTips,
                          style: TextStyle(color: BWColors.depError),
                        ),
                      ),
                  ],
                );
              }),
          StreamBuilder<bool>(
              stream: _streamShowTipsController.stream,
              initialData: isShowDiscountTip,
              builder: (context, snapshot) {
                return snapshot.data
                    ? DepositDisTipsView(
                        widget.data[selTypeIndex].depositRate,
                        widget.data[selTypeIndex].maxDailyDiscount,
                        _showDisDialog,
                      )
                    : Container();
              }),
          Container(
            height: 85,
            width: MediaQuery.of(context).size.width,
            color: BWColors.allGgColor,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            child: StreamBuilder<bool>(
                stream: _streamSubmitController.stream,
                initialData: disabledSubmit,
                builder: (context, snapshot) {
                  return FlatButton(
                    color: BWColors.dssBtnBg,
                    disabledColor: Colors.blueGrey,
                    child: Text(
                      Strings.depositNow,
                      style:
                          TextStyle(fontSize: 16, color: BWColors.dssBtnText),
                    ),
                    onPressed: snapshot.data ? () => _submit() : null,
                  );
                }),
          ),
          SupportFooterView(),
        ]),
      ),
    );
  }

  void setIsShowDisTip(int index) {
    isShowDiscountTip =
        !StringUtil.isNullOrEmpty(widget.data[index].depositRate) ||
            !StringUtil.isNullOrEmpty(widget.data[index].maxDailyDiscount);
    var typeId = widget.data[index].pay_type_id;
    //如果显示优惠，并且没有当前优惠列表，去获取。
    if (isShowDiscountTip && !discountCache.containsKey(typeId)) {
      getDiscountList(typeId);
    }
  }

  ///获取优惠列表
  getDiscountList(String typeId) async {
    DepDisEntity entity = await ApiDeposit.getDepositDicList(typeId);
    if (entity.code == 0 && entity.data.isNotEmpty) {
      discountCache[typeId] = entity.data;
    }
  }

  /// 存款金额item
  Widget _buildMoneyItem(int money, bool isSel) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: isSel ? BWColors.depItemSel : BWColors.dssDivider,
              width: 1,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            money == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '其他金额',
                        style: TextStyle(
                            fontSize: 10,
                            color: isSel
                                ? BWColors.depItemSel
                                : BWColors.depItemNor),
                      ),
                      Text(
                        '(100-49999)',
                        style: TextStyle(
                            fontSize: 10,
                            color: isSel
                                ? BWColors.depItemSel
                                : BWColors.depItemNor),
                      ),
                    ],
                  )
                : Text(
                    '￥$money',
                    style: TextStyle(
                        fontSize: 10,
                        color:
                            isSel ? BWColors.depItemSel : BWColors.depItemNor),
                  ),
            if (isSel)
              Align(
                alignment: Alignment.bottomRight,
                child: SimpleImageView.assetImage(R.deposit_type_selected,
                    width: 16, height: 16),
              ),
          ],
        ));
  }

  int _getRandomSuffix() {
    return Random().nextInt(8) + 1;
  }

  //初始化金额
  void _initMoneyList() {
    moneyList.add(100 + _getRandomSuffix());
    moneyList.add(500 + _getRandomSuffix());
    moneyList.add(1000 + _getRandomSuffix());
    moneyList.add(2000 + _getRandomSuffix());
    moneyList.add(4990 + _getRandomSuffix());
    moneyList.add(0);
  }

  /// 支付方式item
  Widget _buildPayTypeItem(TypeEntryBean data, bool isSel) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: isSel ? BWColors.depItemSel : BWColors.dssDivider,
            width: 1,
            style: BorderStyle.solid),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SimpleImageView.displayIcon(data.icon,
                  width: 32, height: 32, errorAsset: R.desposit_onlinepay),
              Text(
                StringUtil.isNullOrEmpty(data.typeName)
                    ? '其他金额'
                    : data.typeName,
                style: TextStyle(
                    fontSize: 12,
                    color: isSel ? BWColors.depItemSel : BWColors.depItemNor),
                maxLines: 1,
              ),
              if (!StringUtil.isNullOrEmpty(data.depositRate))
                Text(
                  "加送${data.depositRate}%",
                  style: TextStyle(fontSize: 10, color: BWColors.depItemTips),
                  maxLines: 1,
                ),
            ],
          ),
          if (data.recommend == 1)
            Positioned(
              right: 0,
              top: 0,
              child: SimpleImageView.assetImage(R.deposit_type_recomm,
                  width: 30, height: 30),
            ),
          if (isSel)
            Positioned(
              right: 0,
              bottom: 0,
              child: SimpleImageView.assetImage(R.deposit_type_selected,
                  width: 16, height: 16),
            ),
        ],
      ),
    );
  }

  ///存款人姓名输入
  _buildNameWidget() {
    return StreamBuilder<int>(
        stream: _streamNameController.stream,
        initialData: 0,
        builder: (context, snapshot) {
          return Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 10,
                  color: BWColors.dssDivider,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 14, right: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '*',
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(
                        '存款人姓名',
                        style: TextStyle(
                          fontSize: 16,
                          color: BWColors.depInput,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          //允许的输入格式
                          keyboardType: TextInputType.text,
                          controller: _nameController,
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            hintText: '请输入存款人姓名',
                            border: InputBorder.none,
                            counterText: "",
                          ),
                          maxLines: 1,
                          maxLength: 20,
                          style: TextStyle(
                            fontSize: 16,
                            color: BWColors.depInput,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14, bottom: 8),
                  child: Divider(
                    height: 1,
                    color: BWColors.dssDivider,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 14, right: 16, bottom: 8),
                    child: IndexedStack(
                      index: snapshot.data,
                      children: <Widget>[
                        Text(
                          '为及时到账，请务必输入正确的存款人姓名',
                          style:
                              TextStyle(fontSize: 10, color: BWColors.dssDesc),
                        ),
                        Text(
                          '为及时到账，请务必输入正确的存款人姓名',
                          style: TextStyle(fontSize: 14, color: Colors.red),
                        ),
                      ],
                    )),
              ],
            ),
          );
        });
  }

  // 设置提交按钮状态
  _setSubmitBtnState() {
    if (isRequiredMoney && !verifyMoney) {
      disabledSubmit = false;
      _streamSubmitController.sink.add(false);
      return;
    }
    if (isRequiredName && !verifyName) {
      disabledSubmit = false;
      _streamSubmitController.sink.add(false);
      return;
    }
    disabledSubmit = true;
    _streamSubmitController.sink.add(true);
  }

  //提交
  _submit() async {
    String name;
    int money = moneyList[selMoneyIndex];
    String type = widget.data[selTypeIndex].pay_type_id;
    if (isRequiredName) {
      name = _nameController.text.toString();
    }
    if (isRequiredMoney) {
      money = int.parse(_moneyController.text.toString());
    }
    DepositPayEntity entity =
        await ApiDeposit.loadPayment(money, type, depositName: name);

    if (entity.code == 0) {
      Navigator.of(context).pushNamed(BwSpRoutes.depositOrder,
          arguments:  entity.data);
    } else {
      showToast(entity.msg);
    }
  }

  //如果转账的就跳转
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      // 判断当前手机是否安装某app. 能否正常跳转
      await launch(url);
    } else {
//      val dialog = CommonDialogFactory.createDialogByType(context, DialogType.DIALOG_TYPE_1001)
//      dialog.setContentText("未检测到客户端，请安装后重试。")
//      dialog.setOnConfirmListener { dialog.dismiss() }
//      dialog.show()
    }
  }

  ///验证名字是否合法
  bool _verifyName(String name) {
    if (name.length < 2) {}
    RegExp nameReg = new RegExp(r"^[\u4e00-\u9fa5a-zA-Z.·•]+$");
    if (!nameReg.hasMatch(name)) {
      return false;
    }

    if (name.startsWith(" ") || name.startsWith("·")) {
      return false;
    }

    if (name.endsWith(" ") ||
        name.endsWith("·") ||
        name.endsWith("•") ||
        name.endsWith(".")) {
      return false;
    }
    if (name.contains("  ")) {
      return false;
    }
    if (name.contains("··")) {
      return false;
    }
    return true;
  }

  ///验证金额是否合法
  bool _verifyMoney(String money) {
    if (StringUtil.isNullOrEmpty(money)) {
      return false;
    }
    if (double.parse(money) < 100 || double.parse(money) > 49999) {
      return false;
    }
    return true;
  }

  _showDisDialog() {
    var type = widget.data[selTypeIndex].pay_type_id;
    if (discountCache.containsKey(type)) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return DepositDiscountDialog(discountCache[type]);
          });
    }

  }
}
