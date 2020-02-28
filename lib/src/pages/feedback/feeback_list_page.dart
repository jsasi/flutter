import 'package:bw_res/bw_res.dart';
import 'package:bw_sponsor_preferential/src/model/feedback_entity.dart';
import 'package:bw_sponsor_preferential/src/pages/discount_details/discount_details_page.dart';
import 'package:bw_sponsor_preferential/src/pages/feedback/feedback_details_page.dart';
import 'package:bw_sponsor_preferential/src/pages/feedback/feedback_list_model.dart';
import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:bw_sponsor_preferential/src/widgets/feedback_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../common/page_status.dart';
import '../../routers/routes.dart';
import '../../widgets/net_error_view.dart';

/// 优惠列表页面
class FeedbackListPage extends StatefulWidget {
  @override
  _FeedbackListPageState createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  RefreshController _refreshController = RefreshController();
  final viewModel = FeedbackListModel();

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
      appBar: DssAppBar(
        Strings.feeMyTitle,
        hideLeftArrow: false,
        rightImg: R.feedback_add,
        callBack: () => Navigator.pushNamed(context, Routes.feedback),
      ),
      body: ChangeNotifierProvider<FeedbackListModel>.value(
        value: viewModel,
        child: Consumer<FeedbackListModel>(builder: (context, vm, child) {
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
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () => viewModel.refresh(),
          onLoading: () => viewModel.loadMore(),
          controller: _refreshController,
          child: _buideList(viewModel.results)),
    );
  }

  /// 数据页面
  /// [datas] 展示数据列表
  ListView _buideList(List<FeedbackItemBean> datas) {
    return ListView.separated(
      itemCount: datas.length,
      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 1,
          color: Colors.white,
          child: Divider(
            height: 1,
            indent: 58,
            color: BWColors.serviceBg,
          ),
        );
      },
      itemBuilder: (context, index) => InkWell(
          onTap: () => Navigator.pushNamed(
              context, Routes.feedbackDetails,
              arguments: {FeedbackDetailsPage.KEY_ID: datas[index].id}),
          child: FeedbackItem(datas[index])),
    );
  }
}
