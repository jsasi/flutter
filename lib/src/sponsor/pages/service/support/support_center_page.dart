import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_res/res/res.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_sponsor_preferential/src/common/page_status.dart';
import 'package:bw_sponsor_preferential/src/routers/routes.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/service_entity.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/support_type_entity.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/service/support/support_center_model.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/service/support/support_details_page.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/web/web_page.dart';
import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:bw_sponsor_preferential/src/widgets/empty_view_.dart';
import 'package:bw_sponsor_preferential/src/widgets/net_error_view.dart';
import 'package:bw_sponsor_preferential/src/widgets/support_footer_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 帮助中心列表页面
class SupportCenterListPage extends StatefulWidget {


  SupportCenterListPage({Key key, @required this.bean}) : super(key: key);
  final ServiceItemBean bean;

  @override
  _SupportCenterListPageState createState() => _SupportCenterListPageState();
}

class _SupportCenterListPageState extends State<SupportCenterListPage> {
  RefreshController _refreshController = RefreshController();
  SupportCenterModel _viewModel;

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _viewModel = SupportCenterModel(widget.bean.id);
    _viewModel.init();
    //客服点击 todo
//    _recognizer.onTap = () => Navigator.pushNamed(context, Routes.service);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DssAppBar(
        widget.bean.name ?? "",
        hideLeftArrow: false,
        rightImg: R.service_icon,
        callBack: () => Navigator.pushNamed(context, BwSpRoutes.customerService),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        color: Colors.white,
        child: ChangeNotifierProvider<SupportCenterModel>.value(
          value: _viewModel,
          child: Consumer<SupportCenterModel>(builder: (context, vm, child) {
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
        onRefresh: () => _viewModel.refresh(),
        controller: _refreshController,
        child: _buideList(_viewModel.results));
  }

  /// 数据页面
  /// [datas] 展示数据列表
  ListView _buideList(List<SupportItemBean> datas) {
    return ListView.separated(
      itemCount: datas.length + 1,
      itemBuilder: (context, index) => index == datas.length
          ? SupportFooterView()
          : _buildItem(datas[index]),
      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.only(left: 14),
          height: 1,
          child: Divider(
            height: 1,
            color: BWColors.dssDivider,
          ),
        );
      },
    );
  }

  _itemClick(SupportItemBean data) {
    if (data.contextType == 1) {
      Navigator.pushNamed(context, BwSpRoutes.supportDetails,
          arguments: data.id);
    } else if (data.contextType == 2) {
      Navigator.pushNamed(context, BwSpRoutes.webPage, arguments: {
        WebPage.KEY_URL: widget.bean.linkUrl,
        WebPage.KEY_TITLE: widget.bean.name
      });
    }
  }

  Widget _buildItem(SupportItemBean data) {
    return InkWell(
      onTap: () => _itemClick(data),
      child: Container(
        height: 70,
        padding: EdgeInsets.only(left: 14, right: 14),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              data.title ?? "",
              style: TextStyle(
                  fontSize: 14,
                  color: BWColors.serviceItemDesc,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
            )),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 13,
                color: BWColors.dssItemArrow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
