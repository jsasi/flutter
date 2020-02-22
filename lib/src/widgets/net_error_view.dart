import 'package:flutter/material.dart';

/// 网络错误展示view
/// [callBack] 点击回调
class NetErrorView extends StatelessWidget {
  NetErrorView({Key key, this.callBack}) : super(key: key);

  final Function callBack;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.network_wifi),
          Text('网络不给力'),
          Text('别紧张，刷新页面试试'),
          FlatButton(
            child: Text(
              '刷新一下',
              style: TextStyle(fontSize: 14),
            ),
            color: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            onPressed: callBack,
          )
        ],
      ),
    );
  }
}
