import 'package:bw_base/bw_base.dart';
import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_sponsor_preferential/src/common/h5_url_format.dart';
import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:bw_utils/bw_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 赞助详情页
class SponsorDetailsPage extends StatelessWidget {
  const SponsorDetailsPage({Key key, this.title,this.url}) : super(key: key);
  final String title;
  final String url;
  static final String KEY_URL = "key_url";
  static final String KEY_TITLE = "key_title";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DssAppBar(
          title?? Strings.spoTitle,
          hideLeftArrow: false,
        ),
        body: BwWebview(
         url: H5UrlFormat.appendUrl(url),
        ));
  }
}
