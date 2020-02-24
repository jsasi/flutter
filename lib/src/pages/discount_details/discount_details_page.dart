import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_sponsor_preferential/src/common/h5_url_format.dart';
import 'package:bw_utils/bw_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscountDetailsPage extends StatelessWidget {
  DiscountDetailsPage({Key key, this.arguments}) : super(key: key);
  final arguments;
  static final String KEY_URL = "key_url";
  static final String KEY_TITLE = "key_title";

  @override
  Widget build(BuildContext context) {
    debugPrint(arguments != null ? arguments["id"] : "ss");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: BWColors.disTitle,
              ),
              onPressed: () => Navigator.of(context).pop()),
          title: Text(
            arguments != null ? arguments[KEY_TITLE] : Strings.disDetailsTitle,
            style: TextStyle(fontSize: 18, color: BWColors.disTitle),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_downward),
            ),
          ],
        ),
        body: CommonWebview(
          H5UrlFormat.getH5Url(""),
          showTitleBar: false,
        ));
  }
}
