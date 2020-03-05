import 'package:bw_base/bw_base.dart';
import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:flutter/material.dart';

class WebPage extends StatelessWidget {
  WebPage( {Key key,@required this.url,this.title,}) : super(key: key);

  static const String KEY_URL = "key_url";
  static const String KEY_TITLE = "key_title";

final  String url;
final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DssAppBar(
          title,
          hideLeftArrow: false,
        ),
        body: BwWebviewPage(
          url: url,
        ));
  }
}
