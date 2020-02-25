import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_sponsor_preferential/src/widgets/simple_imageview.dart';
import 'package:flutter/material.dart';

/// 空视图展示view
class EmptyView extends StatelessWidget {
  EmptyView(this.text, this.img, {Key key, this.callback, this.btnText})
      : super(key: key);

  /// [desc] 空视图描述
  final String text;

  /// [res] 空视图本地图片资源
  final String img;

  /// [callback] 按钮回调 为空则不显示按钮
  Function callback;

  /// [btnText] 按钮文字
  String btnText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SimpleImageView.assetImage(img,
              width: 165, height: 165),
          Padding(
            padding: EdgeInsets.only(top: callback == null ? 55 : 24),
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: BWColors.serviceItemDesc),
            ),
          ),
          if (callback != null)
            SizedBox(
              width: 160,
              height: 40,
              child: FlatButton(
                color: BWColors.dssBtnBg,
                child: Text(
                  btnText,
                  style: TextStyle(fontSize: 14, color: BWColors.dssBtnText),
                ),
              ),
            )
        ],
      ),
    );
  }
}
