import 'dart:convert';

import 'package:bw_base/bw_base.dart';
import 'package:bw_sponsor_preferential/src/model/customer_entity.dart';
import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:flutter/material.dart';

/// 客服
class CustomerServicePage extends StatefulWidget {
  CustomerServicePage({Key key, this.arguments}) : super(key: key);

  static const String KEY_INDEX = "key_index";

  final arguments;

  @override
  _CustomerServicePageState createState() => _CustomerServicePageState();
}

class _CustomerServicePageState extends State<CustomerServicePage> {
  int _index;
  List<CustomerEntity> customerList;
  final String  defUrl =
      "https://chat.8ztq7o.com/chat/chatClient/chatbox.jsp?companyID=5889090&configID=2";
  void _initArguments() {
    if (widget.arguments != null) {
      _index = widget.arguments[CustomerServicePage.KEY_INDEX];
    }
  }

  @override
  void initState() {
    super.initState();
    _initArguments();
    _genCustomer();
  }

  /// 获取客服列表
  _genCustomer() {
    List list = json
        .decode(PreInfoUtil.getPreInfoEntity().siteBaseConfig.customerService);
    customerList = list.map((m) => CustomerEntity.fromJson(m)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DssAppBar(
          "客服",
          hideLeftArrow: false,
        ),
        body: BwWebview(
          customerList != null && customerList.length > _index
              ? customerList[_index].url
              : defUrl,
          showTitleBar: false,
        ));
  }
}
