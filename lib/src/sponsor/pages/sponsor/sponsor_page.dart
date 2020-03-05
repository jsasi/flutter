import 'package:bw_base/bw_base.dart';
import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_res/res/res.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_sponsor_preferential/bw_sponsor_preferential.dart';
import 'package:bw_sponsor_preferential/src/common/h5_url_format.dart';
import 'package:bw_sponsor_preferential/src/common/page_status.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/sponsor_entity.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/sponsor/sponsor_details_page.dart';
import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:bw_sponsor_preferential/src/widgets/empty_view_.dart';
import 'package:bw_sponsor_preferential/src/widgets/net_error_view.dart';
import 'package:bw_sponsor_preferential/src/widgets/sponsor_item.dart';
import 'package:bw_utils/bw_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'sponsor_model.dart';

/// 赞助页面
class SponsorPage extends StatefulWidget {
  @override
  _SponsorPageState createState() => _SponsorPageState();
}

class _SponsorPageState extends State<SponsorPage> {
  RefreshController _refreshController = RefreshController();

  final viewModel = SponsorModel();

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
      appBar: DssAppBar(Strings.spoTitle),
      body: ChangeNotifierProvider<SponsorModel>.value(
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
      ),
    );
  }

  /// 数据页面
  Widget _buildContentWidget() {
    if (viewModel.results.length == 1) {
      return BwWebview(
       url: H5UrlFormat.appendUrl(viewModel.results[0].infoUrl),
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
              Navigator.pushNamed(context, BwSpRoutes.sponsorDetails, arguments: {
                SponsorDetailsPage.KEY_URL: datas[index].infoUrl,
                SponsorDetailsPage.KEY_TITLE: datas[index].sponsoredTile
              }),
          child: SponsorItem(datas[index])),
    );
  }
}
