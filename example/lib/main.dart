import 'package:bw_sponsor_preferential/bw_sponsor_preferential.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import 'debug_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Color(0x66000000),
            )),
        home: DebugPage(),
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
