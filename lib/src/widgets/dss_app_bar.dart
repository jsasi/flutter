import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_sponsor_preferential/src/widgets/simple_imageview.dart';
import 'package:flutter/cupertino.dart';
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
    return SafeArea(
      child: Container(
        height: 45,
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        child: Stack(
          children: <Widget>[
            if (!hideLeftArrow)
              IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(
                    CupertinoIcons.back,
                    color: BWColors.dssTitleLeftArrow,
                    size: 16,
                  ),
                  onPressed: () => Navigator.of(context).pop()),
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  color: BWColors.disTitle,
                ),
                maxLines: 1,
              ),
            ),
            if (rightText != null)
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: callBack,
                  child: Text(
                    rightText,
                    style:
                        TextStyle(fontSize: 14, color: BWColors.disTitle),
                  ),
                ),
              ),
            if (rightImg != null)
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: callBack,
                  child: SimpleImageView.assetImage(rightImg,
                      width: 16, height: 16),
                ),
              )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(45);
}
