import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_utils/bw_utils.dart';
import 'package:flutter/material.dart';

class CustomerServicePage extends StatelessWidget {
  CustomerServicePage({Key key, this.arguments}) : super(key: key);

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
        body: CommonWebview(
          _url,
          canGoBack: false,
          showTitleBar: false,
        ));
  }

  Widget _buildAppBar() {
    return Container(
      height: 45,
      alignment: Alignment.center,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          if (true)
            Padding(
              padding: EdgeInsets.only(left: 14),
              child: Icon(
                Icons.arrow_back_ios,
                size: 14,
                color: Colors.black12,
              ),
            ),
          Expanded(
            child: Text(
              'text',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          if (true)
            Padding(
              padding: EdgeInsets.only(left: 14),
              child: Text(
                'text',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            )
        ],
      ),
    );
  }
}
