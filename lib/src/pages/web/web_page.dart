import 'package:bw_base/bw_base.dart';
import 'package:flutter/material.dart';

class WebPage extends StatelessWidget {
  WebPage(this.arguments, {Key key}) : super(key: key);

  static final String KEY_URL = "key_url";

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
//        appBar: AppBar(
//          backgroundColor: Colors.white,
//          leading: IconButton(
//              icon: Icon(
//                Icons.arrow_back_ios,
//                color: BWColors.dssTitleLeftArrow,
//                size: 14,
//              ),
//              onPressed: () => Navigator.of(context).pop()),
//          centerTitle: true,
//          title: Text(
//            Strings.homeCustomer,
//            style: TextStyle(fontSize: 18, color: BWColors.disTitle),
//          ),
//        ),
        body: BwWebview(
          _url,
          showTitleBar: false,
        ));
  }

}
