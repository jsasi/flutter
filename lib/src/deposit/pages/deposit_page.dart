import 'package:bw_base/bw_base.dart';
import 'package:bw_res/res/res.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_sponsor_preferential/bw_sponsor_preferential.dart';
import 'package:bw_sponsor_preferential/src/common/page_status.dart';
import 'package:bw_sponsor_preferential/src/deposit/pages/deposit_model.dart';
import 'package:bw_sponsor_preferential/src/deposit/pages/deposit_view.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/api_service.dart';
import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:bw_sponsor_preferential/src/widgets/net_error_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DepositPage extends StatefulWidget {
  DepositPage({Key key}) : super(key: key);

  @override
  _DepositPageState createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  bool _isShowHelpIcon = false;
  var vm = DepositModel();

  @override
  void initState() {
    super.initState();
    vm.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //根据帮助中心设置标题栏右侧按钮
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
    print("====build========");
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
            callBack: () => Navigator.of(context).pushNamed(BwSpRoutes.helpCenter),
          )
        : DssAppBar(Strings.depositTitle, hideLeftArrow: false);
  }

  //返回主体布局
  // ignore: missing_return
  Widget _buildBody() {
   return ChangeNotifierProvider<DepositModel>.value(
        value: vm,
        child: Consumer<DepositModel>(builder: (context, vm, child) {
          switch (vm.screenStatus) {
            case ScreenStatus.LoadSuccess:
              if (vm.isShowOrder) {
                return _buildOrider();
              } else {
                return DepositView(vm.typeList);
              }
              break;
            case ScreenStatus.Error:
              return NetErrorView();
            default:
              return Center(
                child: BwLoading(),
              );
          }
        }));
  }

  Widget _buildOrider() {
    return Text('text');
  }
}
