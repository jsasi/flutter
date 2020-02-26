import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:bw_utils/bw_utils.dart';
import 'package:flutter/material.dart';

/// 客服
class CustomerServicePage extends StatelessWidget {
  CustomerServicePage({Key key, this.arguments}) : super(key: key);

  static const String KEY_URL = "key_url";

  final arguments;
  String _url;

  // 解析路由数据
  void _initArguments() {
    if (arguments != null) {
      _url = arguments[KEY_URL];
    }
  }

  @override
  Widget build(BuildContext context) {
    _initArguments();
    return Scaffold(
        appBar: DssAppBar("客服"),
        body: CommonWebview(
          _url,
          showTitleBar: false,
        ));
  }
}
