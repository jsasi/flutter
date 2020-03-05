import 'package:biz_login/biz_login.dart';
import 'package:bw_res/bw_res.dart';
import 'package:bw_sponsor_preferential/bw_sponsor_preferential.dart';
import 'package:flutter/material.dart';

import 'debug_page.dart';

class AppRoute extends NavigatorObserver {
  AppRoute._();

  static final AppRoute _appRoute = AppRoute._();

  factory AppRoute() => _appRoute;

  /// 静态路由（无参数）
  static final Map<String, WidgetBuilder> _routes = {
    //这里只能定义调试用路由
    '/': (_) => DebugPage(),
  }
    ..addAll(loginRoute.packageRoutes())
  ..addAll(BwSpRoutes.routes);

  Map<String, WidgetBuilder> get routes => _routes;

  /// 带参数路由
  Route<dynamic> generateRoute(RouteSettings settings) {
    MaterialPageRoute targetPage = loginRoute.generatePackageRoute(settings);
    if (targetPage == null) {
      targetPage = BwSpRoutes.generatePackageRoute(settings);
    }
    return targetPage;
  }
}

AppRoute appRoute = AppRoute();
