import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_utils/bw_utils.dart';
import 'package:flutter/material.dart';

/// 存款优惠提示
class DepositDisTipsView extends StatefulWidget {
  DepositDisTipsView({Key key, this.depositRate, this.maxDailyDiscount,this.isShow})
      : super(key: key);
  final String depositRate;
  final String maxDailyDiscount;
  final isShow ;

  @override
  DepositDisTipsViewState createState() {
    return DepositDisTipsViewState(isShow);
  }
}

class DepositDisTipsViewState extends State<DepositDisTipsView> {
  DepositDisTipsViewState(this._isShow){
    print('=======_isShow====$_isShow');

  }
  bool _isShow ;

  setShowState(bool show){
    print('=======show====$show');
    _isShow=show;
    setState(() {

    });
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isShow
        ? Container(
            color: BWColors.allGgColor,
            padding: EdgeInsets.only(left: 14, right: 16, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    if (!StringUtil.isNullOrEmpty(widget.depositRate))
                      Text(
                        '存款成功额外加送：${widget.depositRate}',
                        style: TextStyle(fontSize: 14, color: Colors.red),
                      ),
                    if (!StringUtil.isNullOrEmpty(widget.maxDailyDiscount))
                      Text('每日最高优惠：${widget.maxDailyDiscount}元',
                          style: TextStyle(fontSize: 14, color: Colors.red)),
                  ],
                ),
                Text(
                  '具体到账金额以实际到账为准',
                  style: TextStyle(
                      fontSize: 12, color: Color.fromARGB(255, 170, 170, 170)),
                ),
              ],
            ),
          )
        : Container();
  }
}
