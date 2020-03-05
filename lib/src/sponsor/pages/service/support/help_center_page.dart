import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_res/res/res.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_sponsor_preferential/src/common/page_status.dart';
import 'package:bw_sponsor_preferential/src/routers/routes.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/service_entity.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/service/home/service_model.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/service/support/support_center_page.dart';
import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:bw_sponsor_preferential/src/widgets/empty_view_.dart';
import 'package:bw_sponsor_preferential/src/widgets/net_error_view.dart';
import 'package:bw_sponsor_preferential/src/widgets/refresh_head.dart';
import 'package:bw_sponsor_preferential/src/widgets/service_item.dart';
import 'package:bw_sponsor_preferential/src/widgets/support_footer_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 帮助中心列表页面
class HelpCenterPage extends StatefulWidget {
  HelpCenterPage({Key key}) : super(key: key);

  @override
  _HelpCenterListPageState createState() => _HelpCenterListPageState();
}

class _HelpCenterListPageState extends State<HelpCenterPage> {
  RefreshController _refreshController = RefreshController();
  final _viewModel = ServiceModel();

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DssAppBar(
        '帮助中心',
        hideLeftArrow: false,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        color: Colors.white,
        child: ChangeNotifierProvider<ServiceModel>.value(
          value: _viewModel,
          child: Consumer<ServiceModel>(builder: (context, vm, child) {
            switch (vm.screenStatus) {
              case ScreenStatus.Error:
                return NetErrorView(callBack: () => _viewModel.init());
              case ScreenStatus.Loading:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ScreenStatus.RefreshComplete:
                _refreshController.refreshCompleted(resetFooterState: true);
                return _buildContentWidget();
              case ScreenStatus.RefreshFail:
                _refreshController.refreshFailed();
                return _buildContentWidget();
              case ScreenStatus.Empty:
                return EmptyView(
                    Strings.supportEmptyTitle, R.support_empty_history);
              default:
                return _buildContentWidget();
            }
          }),
        ),
      ),
    );
  }

  /// 数据页面
  Widget _buildContentWidget() {
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: RefreshHead(),
        onRefresh: () => _viewModel.refresh(),
        controller: _refreshController,
        child: _buideList(_viewModel.results));
  }

  /// 数据页面
  /// [datas] 展示数据列表
  ListView _buideList(List<ServiceItemBean> datas) {
    return ListView.separated(
      itemCount: datas.length,
      itemBuilder: (context, index) => InkWell(
          onTap: () => Navigator.pushNamed(context, BwSpRoutes.supportCenter,
              arguments:  datas[index]),
          child: ServiceItem(datas[index])),
      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.only(left: 56),
          height: 1,
          color: Colors.white,
          child: Divider(
            height: 1,
            color: BWColors.serviceBg,
          ),
        );
      },
    );
  }
}
