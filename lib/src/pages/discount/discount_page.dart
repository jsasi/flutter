import 'package:bw_res/bw_res.dart';
import 'package:bw_res/res/bw_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../common/page_status.dart';
import '../../routers/routes.dart';
import '../../widgets/discount_item.dart';
import '../../widgets/net_error_view.dart';
import '../model/discount_entity.dart';
import 'discount_model.dart';

/// 优惠列表页面
class DiscountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            Strings.disTitle,
            style: TextStyle(fontSize: 16, color: BWColors.disTitle),
          ),
          backgroundColor: Colors.white,
        ),
        body: _BodyWidget());
  }
}

/// 页面主体widget
class _BodyWidget extends StatelessWidget {
  RefreshController _refreshController = RefreshController();
  final viewModel = DiscountModel();

  @override
  Widget build(BuildContext context) {
    viewModel.init();
    return ChangeNotifierProvider<DiscountModel>.value(
      value: viewModel,
      child: Consumer<DiscountModel>(builder: (context, vm, child) {
        switch (vm.screenStatus) {
          case ScreenStatus.Error:
            return NetErrorView(callBack: () => viewModel.init());
          case ScreenStatus.Loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ScreenStatus.RefreshComplete:
            _refreshController.refreshCompleted(resetFooterState: true);
            return _buildRefreshWidget();
          case ScreenStatus.RefreshFail:
            _refreshController.refreshFailed();
            return _buildRefreshWidget();
          case ScreenStatus.LoadMoreNoData:
            _refreshController.loadNoData();
            return _buildRefreshWidget();
          case ScreenStatus.LoadMoreComplete:
            _refreshController.loadComplete();
            return _buildRefreshWidget();
          case ScreenStatus.LoadMoreFail:
            _refreshController.loadFailed();
            return _buildRefreshWidget();
          case ScreenStatus.Empty:
            return Center(
              child: Text('数据为空'),
            );
          default:
            return _buildRefreshWidget();
        }
      }),
    );
  }

  /// 数据页面
  /// [viewModel] vm
  Widget _buildRefreshWidget() {
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: () => viewModel.refresh(),
        onLoading: () => viewModel.loadMore(),
        controller: _refreshController,
        child: _buideList(viewModel.results));
  }

  /// 数据页面
  /// [datas] 展示数据列表
  ListView _buideList(List<DiscountItemBean> datas) {
    return ListView.builder(
      itemCount: datas.length,
      itemBuilder: (context, index) => InkWell(
          onTap: () => Navigator.pushNamed(context, Routes.discountDetails),
          child: DiscountItem(datas[index])),
    );
  }
}
