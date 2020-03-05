import 'package:bw_base/bw_base.dart';
import 'package:bw_res/res/res.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_sponsor_preferential/src/common/h5_url_format.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/discount_entity.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/discount_details/discount_details_dialog.dart';
import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///优惠详情页
class DiscountDetailsPage extends StatelessWidget {
  DiscountDetailsPage({
    Key key,
    @required this.data,
  }) : super(key: key);
  final DiscountItemBean data;

  // 弹出底部菜单列表模态对话框
  Future<bool> _showModalBottomSheet(BuildContext context) {
    return showModalBottomSheet<bool>(
        isScrollControlled: true,
        context: context,
        builder: (context) => DialogSavePic(
            data?.sharePicture ?? "",
            data?.title ?? "",
            data?.activityStartTime ?? "",
            data?.activityEndTime ?? ""));
  }

  String _getDetailsUrl() {
    String appLink = data.appTopicLink;
    if (appLink.isNotEmpty) {
      if (!appLink.contains("http") && !appLink.contains("https")) {
        appLink = H5UrlFormat.appendUrl(appLink);
      }
    } else {
      appLink =
          H5UrlFormat.appendUrl("/app/promo/list/${data.id}"); //;+ data?.id
    }
    return appLink;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DssAppBar(
          data != null ? data.title : Strings.disDetailsTitle,
          hideLeftArrow: false,
          rightImg: R.discount_title_share,
          callBack: () => _showModalBottomSheet(context),
        ),
        body: BwWebview(
          url: _getDetailsUrl(),
        ));
  }
}
