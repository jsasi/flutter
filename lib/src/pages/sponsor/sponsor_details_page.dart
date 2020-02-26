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
  const SponsorDetailsPage({Key key, this.arguments}) : super(key: key);
  final arguments;
  static final String KEY_URL = "key_url";
  static final String KEY_TITLE = "key_title";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DssAppBar(
          arguments != null ? arguments[KEY_TITLE] : Strings.spoTitle,
          hideLeftArrow: false,
        ),
        body: BwWebview(
          H5UrlFormat.appendUrl(arguments[KEY_URL]),
          showTitleBar: false,
        ));
  }
}
