import 'dart:convert';

import 'package:bw_base/bw_base.dart';
import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:flutter/material.dart';

/// 客服
class CustomerServicePage extends StatefulWidget {
  CustomerServicePage({Key key,@required this.url,}) : super(key: key);
  final String url;
  @override
  _CustomerServicePageState createState() => _CustomerServicePageState();
}

class _CustomerServicePageState extends State<CustomerServicePage> {



  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DssAppBar(
        "客服",
        hideLeftArrow: false,
      ),
        body: BwWebview(
          url:widget.url,
        )
    );
  }
}
