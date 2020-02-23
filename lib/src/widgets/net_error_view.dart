import 'package:bw_res/bw_res.dart';
import 'package:bw_res/res/bw_colors.dart';
import 'package:flutter/material.dart';

/// 网络错误展示view
/// [callBack] 点击回调
class NetErrorView extends StatelessWidget {
  NetErrorView({Key key, this.callBack}) : super(key: key);

  final Function callBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(R.net_error, package: Strings.bwResPackage),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(Strings.netErrTitle),
          ),
          Text(Strings.netErrDesc),
          Container(
            margin: EdgeInsets.only(top: 30),
            width: 140,
            height: 40,
            child: FlatButton(
              child: Text(
                Strings.netErrBtnText,
                style: TextStyle(fontSize: 14, color: BWColors.netErrBtnText),
              ),
              color: BWColors.netErBtnBg,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              onPressed: callBack,
            ),
          )
        ],
      ),
    );
  }
}
