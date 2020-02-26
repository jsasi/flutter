import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_res/res/res.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_sponsor_preferential/src/model/discount_entity.dart';
import 'package:bw_sponsor_preferential/src/pages/discount_details/discount_details_dialog.dart';
import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:bw_utils/bw_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///优惠详情页
// ignore: must_be_immutable
class DiscountDetailsPage extends StatelessWidget {
  DiscountDetailsPage({Key key, this.arguments}) : super(key: key);
  final arguments;
  static const String KEY_URL = "key_url";
  static const String KEY_DATA = "key_data";

  DiscountItemBean _data;
  String _url;

  // 弹出底部菜单列表模态对话框
  Future<bool> _showModalBottomSheet(BuildContext context) {
    return showModalBottomSheet<bool>(
        isScrollControlled: true,
        context: context,
        builder: (context) => DialogSavePic(
            _data?.sharePicture ?? "",
            _data?.title ?? "",
            _data?.activityStartTime ?? "",
            _data?.activityEndTime ?? ""));
  }

  // 解析路由数据
  void _initArguments() {
    if (arguments != null) {
      _data = arguments[KEY_DATA];
      _url = arguments[KEY_URL];
    }
  }

  @override
  Widget build(BuildContext context) {
    _initArguments();
    return Scaffold(
        appBar: DssAppBar(
          _data != null ? _data.title : Strings.disDetailsTitle,
          hideLeftArrow: false,
          rightImg: R.discount_title_share,
          callBack: () => _showModalBottomSheet(context),
        ),
        body: CommonWebview(
          _url ?? "",
          showTitleBar: false,
        ));
  }
}
