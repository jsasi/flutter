import 'package:bw_base/bw_base.dart';
import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_res/res/res.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_sponsor_preferential/src/widgets/simple_imageview.dart';
import 'package:bw_utils/bw_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:oktoast/oktoast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/string_ext.dart';

class DialogSavePic extends StatelessWidget {
  String title;

  String sharePicture;
  String activityEndTime;

  String activityStartTime;

  /// 分享链接 生成二维码
  String shareLink;

  DialogSavePic(this.sharePicture, this.title, this.activityStartTime,
      this.activityEndTime);

  /// 生成分享字符串
  _createShareLink() {
    shareLink =
        "${PreInfoUtil.getPreInfoEntity()?.siteBaseConfig?.h5DomainUrl}/entry/register?r_code=";
  }

  /// 复制链接
  _launchURL() async {
    if (await canLaunch(shareLink)) {
      await launch(shareLink);
    } else {
      showToast('Could not launch $shareLink');
    }
  }

  /// 保存图片
  _saveImg() async {}

  @override
  Widget build(BuildContext context) {
    _createShareLink();
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
                          ? SimpleImageView.display(sharePicture)
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
                            title ?? "",
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
                  QrImage(
                    data: shareLink,
                    version: QrVersions.auto,
                    size: 60,
                  ),
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
                onTap: () {
                  _launchURL();
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20, left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        width: 60,
                        height: 60,
                        margin: EdgeInsets.only(bottom: 5),
                        child: Image.asset(
                          R.discount_dialog_copy,
                          package: Strings.bwResPackage,
                        ),
                      ),
                      Text(
                        Strings.disCopyLink,
                        style: TextStyle(
                            fontSize: 10, color: BWColors.disDialogDesc),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _saveImg();
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20, left: 12),
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        width: 60,
                        height: 60,
                        margin: EdgeInsets.only(bottom: 5),
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
                ),
              )
            ],
          ),
        ),
        Divider(
          height: 1,
          color: BWColors.disDialogDivider,
        ),
        Container(
          color: Colors.white,
          width: double.infinity,
          height: 50,
          child: FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              Strings.cancel,
              style: TextStyle(fontSize: 18, color: BWColors.disDialogBtnText),
            ),
          ),
        )
      ],
    );
  }
}
