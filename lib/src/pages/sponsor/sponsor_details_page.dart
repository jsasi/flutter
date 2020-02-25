import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_sponsor_preferential/src/common/h5_url_format.dart';
import 'package:bw_utils/bw_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 赞助详情页
class SponsorDetailsPage extends StatelessWidget {
  const SponsorDetailsPage({Key key, this.arguments}) : super(key: key);
  final arguments;
  static final String KEY_URL = "key_url";
  static final String KEY_TITLE = "key_title";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: BWColors.dssTitleLeftArrow,
                size: 14,
              ),
              onPressed: () => Navigator.of(context).pop()),
          title: Text(
            arguments != null ? arguments[KEY_TITLE] : Strings.spoTitle,
            style: TextStyle(fontSize: 18, color: BWColors.disTitle),
          ),
        ),
        body: CommonWebview(
          H5UrlFormat.getH5Url(arguments[KEY_URL]),
          showTitleBar: false,
        ));
  }
}
