import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_sponsor_preferential/src/widgets/simple_imageview.dart';
import 'package:flutter/material.dart';

///
/// @className: dss_app_bar
/// @description: 自定义ppBar
/// @author: asi
/// @date:  2020/2/26
///
// ignore: must_be_immutable
class DssAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  bool hideLeftArrow;
  String rightText;
  String rightImg;
  Function callBack;

  /// [title]标题
  /// [hideLeftArrow]隐藏左侧返回按钮
  /// [rightText]右侧文本
  /// [rightImg]右侧图标
  /// [callBack]右侧点击事件
  DssAppBar(this.title,
      {this.hideLeftArrow = true,
      this.rightText,
      this.rightImg,
      this.callBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: hideLeftArrow
          ? null
          : IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: BWColors.dssTitleLeftArrow,
                size: 14,
              ),
              onPressed: () => Navigator.of(context).pop()),
      title: Text(
        title,
        style: TextStyle(fontSize: 18, color: BWColors.disTitle),
      ),
      actions: <Widget>[
        if (rightText != null)
          InkWell(
            onTap: callBack,
            child: Center(
              child: Text(
                rightText,
                style: TextStyle(fontSize: 14, color: BWColors.disTitle),
              ),
            ),
          ),
        if (rightImg != null)
          InkWell(
            onTap: callBack,
            child: Center(
              child: SimpleImageView.assetImage(rightText, height: 22),
            ),
          )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(45);
}
