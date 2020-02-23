import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_res/res/res.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_sponsor_preferential/src/model/sponsor_entity.dart';
import 'package:bw_sponsor_preferential/src/pages/sponsor/sponsor_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../common/page_status.dart';
import '../../routers/routes.dart';
import '../../widgets/empty_view_.dart';
import '../../widgets/net_error_view.dart';
import '../../widgets/sponsor_item.dart';
import 'sponsor_model.dart';

/// 赞助页面
class SponsorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            Strings.spoTitle,
            style: TextStyle(fontSize: 16, color: BWColors.spoTitle),
          ),
          backgroundColor: Colors.white,
        ),
        body: _BodyWidget());
  }
}

/// 页面主体widget
class _BodyWidget extends StatefulWidget {
  @override
  __BodyWidgetState createState() => __BodyWidgetState();
}

class __BodyWidgetState extends State<_BodyWidget> {
  RefreshController _refreshController = RefreshController();

  final viewModel = SponsorModel();

  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SponsorModel>.value(
      value: viewModel,
      child: Consumer<SponsorModel>(builder: (context, vm, child) {
        switch (vm.screenStatus) {
          case ScreenStatus.Error:
            return NetErrorView(callBack: () => viewModel.init());
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
          case ScreenStatus.LoadMoreNoData:
            _refreshController.loadNoData();
            return _buildContentWidget();
          case ScreenStatus.LoadMoreComplete:
            _refreshController.loadComplete();
            return _buildContentWidget();
          case ScreenStatus.LoadMoreFail:
            _refreshController.loadFailed();
            return _buildContentWidget();
          case ScreenStatus.Empty:
            return EmptyView(Strings.spoEmptyTitle, R.sponsor_empty_holder);
          default:
            return _buildContentWidget();
        }
      }),
    );
  }

  /// 数据页面
  Widget _buildContentWidget() {
    if (viewModel.results.length == 1) {
      return Center(
        child: Text('只有一条数据'),
      );
    } else {
      return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () => viewModel.refresh(),
          onLoading: () => viewModel.loadMore(),
          controller: _refreshController,
          child: _buideList(viewModel.results));
    }
  }

  /// 数据页面
  /// [datas] 展示数据列表
  ListView _buideList(List<SponorItemBean> datas) {
    return ListView.builder(
      itemCount: datas.length,
      itemBuilder: (context, index) => InkWell(
          onTap: () =>
              Navigator.pushNamed(context, Routes.sponsorDetails, arguments: {
                SponsorDetailsPage.KEY_URL: datas[index].infoUrl,
                SponsorDetailsPage.KEY_TITLE: datas[index].sponsoredTile
              }),
          child: SponsorItem(datas[index])),
    );
  }
}
