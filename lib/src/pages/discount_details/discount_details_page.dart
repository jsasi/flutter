import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_sponsor_preferential/src/model/discount_entity.dart';
import 'package:bw_sponsor_preferential/src/pages/discount_details/discount_details_dialog.dart';
import 'package:bw_utils/bw_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///优惠详情页
// ignore: must_be_immutable
class DiscountDetailsPage extends StatelessWidget {
  DiscountDetailsPage({Key key, this.arguments}) : super(key: key);
  final arguments;
  static final String KEY_URL = "key_url";
  static final String KEY_DATA = "key_data";
  final scaffoldKey = GlobalKey<ScaffoldState>();

  DiscountItemBean _data;
  String _url;


  // 弹出底部菜单列表模态对话框
  Future<bool> _showModalBottomSheet(BuildContext context) {
    return showModalBottomSheet<bool>(
        isScrollControlled: true,
        context: context,
        builder: (context) => DialogSavePic(_data.sharePicture,_data.title,_data.activityStartTime,_data.activityEndTime));
  }

  // 解析路由数据
  void _initArguments() {
    if (arguments != null) {
      print(arguments.runtimeType);
      print(arguments);
      _data = arguments[KEY_DATA];
      _url = arguments[KEY_URL];
    }
  }

  @override
  Widget build(BuildContext context) {
    _initArguments();
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: BWColors.dssTitleLeftArrow,
                size: 14,
              ),
              onPressed: () => Navigator.of(context).pop()),
          centerTitle: true,
          title: Text(
            _data != null ? _data.title : Strings.disDetailsTitle,
            style: TextStyle(fontSize: 18, color: BWColors.disTitle),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () => _showModalBottomSheet(context),
              icon: Icon(Icons.arrow_downward),
            ),
          ],
        ),
        body: CommonWebview(
          _url ?? "",
          showTitleBar: false,
        ));
  }
}
