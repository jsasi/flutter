import 'package:biz_app_init/biz_app_init.dart';
import 'package:bw_sponsor_preferential/bw_sponsor_preferential.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: onGenerateRoute,
        //路由注册
        initialRoute: Routes.root);
  }
}
