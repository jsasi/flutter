import 'package:bw_base/bw_base.dart';
import 'package:bw_sponsor_preferential/bw_sponsor_preferential.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import 'app_route.dart';
import 'debug_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        navigatorKey: bwManager.navigatorKey,
        routes: appRoute.routes,
        onGenerateRoute: appRoute.generateRoute,
        navigatorObservers: [
          appRoute,
        ],
//        onGenerateRoute: BwSpRoutes.onGenerateRoute,
//        home: DebugPage(),
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (context) {return UnknownRoutePage(settings: settings,);});
        },
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Color(0x66000000),
            )),
      ),
    );
  }
}
