import 'package:bw_res/res/bw_colors.dart';
import 'package:flutter/material.dart';

/// 空视图展示view
class EmptyView extends StatelessWidget {
  EmptyView(this.desc, this.res, {Key key}) : super(key: key);

  /// [desc] 空视图描述
  /// [res] 空视图本地图片资源
  final String desc;
  final String res;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(res,width: 165,height: 165,),
          Padding(
            padding: const EdgeInsets.only(top: 55),
            child: Text(
              desc,
              style: TextStyle(fontSize: 14, color: BWColors.serviceItemDesc),
            ),
          ),
        ],
      ),
    );
  }
}
