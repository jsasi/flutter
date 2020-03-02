import 'package:bw_res/res/res.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_sponsor_preferential/bw_sponsor_preferential.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/api_service.dart';
import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DepositPage extends StatefulWidget {
  DepositPage({Key key}) : super(key: key);

  @override
  _DepositPageState createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  bool _isShowHelpIcon = false;

  void getHelpList() async {
    var entity = await ApiService.getSerHelpList();
    if (entity.code == 0 && entity.data.isNotEmpty) {
      setState(() {
        _isShowHelpIcon = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  //根据接口构建不同的appbar
  Widget _buildAppBar() {
    return _isShowHelpIcon
        ? DssAppBar(
            Strings.depositTitle,
            hideLeftArrow: false,
            rightImg: R.deposit_help_center,
            callBack: () => Navigator.of(context).pushNamed(Routes.helpCenter),
          )
        : DssAppBar(Strings.depositTitle, hideLeftArrow: false);
  }

  //返回主体布局
  Widget _buildBody() {


  }
}
