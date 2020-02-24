import 'package:biz_app_init/biz_app_init.dart';
import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_res/res/res.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_sponsor_preferential/src/common/display_image.dart';
import 'package:bw_utils/bw_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../common/string_ext.dart';

class DialogSavePic extends StatelessWidget {
  String title;

  String sharePicture;
  String activityEndTime;

  String activityStartTime;

  DialogSavePic(this.sharePicture, this.title, this.activityStartTime,
      this.activityEndTime);

  /// 生成二维码
  _createQRCodeView() {
    String str = "${appInit.h5Host}/entry/register?r_code=";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Card(
          margin: EdgeInsets.only(left: 47, right: 47),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Container(
                      color: BWColors.disDialogImgBg,
                      child: !StringUtil.isNullOrEmpty(sharePicture)
                          ? SimpleImage.display(sharePicture)
                          : Container(),
                    ),
                  ),
                  if (StringUtil.isNullOrEmpty(sharePicture))
                    Image.asset(
                      R.discount_share_logo_yibo,
                      package: Strings.bwResPackage,
                    ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, top: 10, right: 5, bottom: 5),
                          child: Text(
                            title??"",
                            style: TextStyle(
                                fontSize: 14, color: BWColors.disDialogTitle),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 5, bottom: 10),
                          child: Text(
                            "活动日期：${activityStartTime?.subDate()}至${activityEndTime?.subDate()}",
                            style: TextStyle(
                                fontSize: 10, color: BWColors.disDialogDesc),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 60,
                    height: 60,
                    color: Colors.black,
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 95),
          height: 120,
          color: BWColors.disDialogActionBg,
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20,left: 15),
                      color: Colors.white,
                      width: 60,
                      height: 60,
                      child: Image.asset(
                        R.discount_dialog_copy,
                        package: Strings.bwResPackage,
                      ),
                    ),
                    Text(
                      Strings.disSavePic,
                      style: TextStyle(
                          fontSize: 10, color: BWColors.disDialogDesc),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20,left: 12),
                      color: Colors.white,
                      width: 60,
                      height: 60,
                      child: Image.asset(
                        R.discount_dialog_down,
                        package: Strings.bwResPackage,
                      ),
                    ),
                    Text(
                      Strings.disSavePic,
                      style: TextStyle(
                          fontSize: 10, color: BWColors.disDialogDesc),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(
          height: 2,
          color: Colors.grey[500],
        ),
        Container(
          color: Colors.white,
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 34),
          height: 84,
          child: FlatButton(
            child: Text(
              Strings.cancel,
              style: TextStyle(fontSize: 18, color: BWColors.disDialogTitle),
            ),
          ),
        )
      ],
    );
  }
}
