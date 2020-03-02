import 'package:bw_base/bw_base.dart';
import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:flutter/material.dart';

class WebPage extends StatelessWidget {
  WebPage(this.arguments, {Key key}) : super(key: key);

  static const String KEY_URL = "key_url";
  static const String KEY_TITLE = "key_title";

  final arguments;
  String _url;
  String _title;

  // 解析路由数据
  void _initArguments() {
    if (arguments != null) {
      _url = arguments[KEY_URL] ?? '';
      _title = arguments[KEY_TITLE] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    _initArguments();
    return Scaffold(
        appBar: DssAppBar(
          _title,
          hideLeftArrow: false,
        ),
        body: BwWebview(
          url: _url,
          showTitleBar: false,
        ));
  }
}
