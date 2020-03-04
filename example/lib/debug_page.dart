import 'package:biz_app_init/biz_app_init.dart';
import 'package:biz_login/biz_login.dart';
import 'package:biz_network_main/biz_network_main.dart';
import 'package:bw_sponsor_preferential/bw_sponsor_preferential.dart';
import 'package:flutter/material.dart';

class DebugPage extends StatefulWidget {
  DebugPage({Key key}) : super(key: key);

  @override
  _DebugPageState createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  bool _initialized = false;
  @override
  void initState() {
    super.initState();
    _init();
  }
  
  Future<void> _init() async {
    if(!_initialized) {
      _initialized = true;
      await appInit.initialize();
//      mainClient.setProxy('172.18.11.116', 8888);
      await appInit.initRequest();
    }
  }
  @override
  Widget build(BuildContext context) {
    return !_initialized ? Container() : Scaffold(
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
              onPressed: () => Navigator.of(context).pushNamed(Routes.helpCenter),
              child: Text('帮助中心'),
            ),
            RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed(Routes.sponsor),
              child: Text('赞助'),
            ),
            RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed(Routes.deposit),
              child: Text('存款'),
            ),
            RaisedButton(
              onPressed: () async => await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserRegisterPage())),
              child: Text('注册'),
            ),
            RaisedButton(
              onPressed: () async => await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage())),
              child: Text('登录'),
            ),
          ],
        ));

  }
}
