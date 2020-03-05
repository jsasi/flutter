import 'package:bw_res/bw_res.dart';
import 'package:bw_sponsor_preferential/bw_sponsor_preferential.dart';
import 'package:bw_sponsor_preferential/src/common/page_status.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/discount_entity.dart';
import 'package:bw_sponsor_preferential/src/widgets/discount_item.dart';
import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:bw_sponsor_preferential/src/widgets/load_footer.dart';
import 'package:bw_sponsor_preferential/src/widgets/net_error_view.dart';
import 'package:bw_sponsor_preferential/src/widgets/refresh_head.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'discount_model.dart';

/// 优惠列表页面
class DiscountPage extends StatefulWidget {
  @override
  _DiscountPageState createState() => _DiscountPageState();
}

class _DiscountPageState extends State<DiscountPage> {
  RefreshController _refreshController = RefreshController();
  final viewModel = DiscountModel();

  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DssAppBar(Strings.disTitle),
      body: ChangeNotifierProvider<DiscountModel>.value(
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
      ),
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
        header: RefreshHead(),
        footer: LoadFooter(),
        controller: _refreshController,
        child: _buideList(viewModel.results));
  }

  /// 数据页面
  /// [datas] 展示数据列表
  ListView _buideList(List<DiscountItemBean> datas) {
    return ListView.builder(
      itemCount: datas.length,
      itemBuilder: (context, index) => InkWell(
          onTap: () =>
              Navigator.pushNamed(context, SponsorPreferentialRoute.discountDetails, arguments: datas[index]),
          child: DiscountItem(datas[index])),
    );
  }
}
