import 'package:biz_app_init/biz_app_init.dart';
import 'package:bw_sponsor_preferential/bw_sponsor_preferential.dart';
import 'package:flutter/material.dart';

class DebugPage extends StatelessWidget {
  DebugPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    appInit.initialize();
    return Scaffold(
        appBar: AppBar(
          title: Text('appbarTitle'),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed(Routes.discount),
              child: Text('优惠'),
            ),
            RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed(Routes.service),
              child: Text('客服'),
            ),
            RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed(Routes.sponsor),
              child: Text('赞助'),
            ),
          ],
        ));
    ;
  }
}
