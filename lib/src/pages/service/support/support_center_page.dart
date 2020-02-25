import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_res/res/res.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_sponsor_preferential/src/common/page_status.dart';
import 'package:bw_sponsor_preferential/src/model/service_entity.dart';
import 'package:bw_sponsor_preferential/src/model/support_type_entity.dart';
import 'package:bw_sponsor_preferential/src/pages/service/details/support_details_page.dart';
import 'package:bw_sponsor_preferential/src/pages/service/support/support_center_model.dart';
import 'package:bw_sponsor_preferential/src/widgets/empty_view_.dart';
import 'package:bw_sponsor_preferential/src/widgets/net_error_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../bw_sponsor_preferential.dart';

/// 帮助中心列表页面
class SupportCenterListPage extends StatelessWidget {
  ServiceItemBean _bean;
  final arguments;

  static final String KEY_DATA = "key_data";

  SupportCenterListPage({Key key, this.arguments}) : super(key: key);

  // 解析路由数据
  void _initArguments() {
    if (arguments != null) {
      _bean = arguments[KEY_DATA];
    }
  }

  @override
  Widget build(BuildContext context) {
    _initArguments();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: BWColors.dssTitleLeftArrow,
              size: 14,
            ),
          ),
          centerTitle: true,
          title: Text(
            _bean.name ?? "",
            style: TextStyle(fontSize: 16, color: BWColors.serviceTitle),
          ),
          backgroundColor: Colors.white,
        ),
        body: _BodyWidget(_bean.id));
  }
}

/// 页面主体widget
class _BodyWidget extends StatefulWidget {
  _BodyWidget(this.id);

  final int id;

  @override
  __BodyWidgetState createState() => __BodyWidgetState();
}

class __BodyWidgetState extends State<_BodyWidget> {
  RefreshController _refreshController = RefreshController();
  SupportCenterModel _viewModel;
  final TapGestureRecognizer _recognizer = new TapGestureRecognizer();

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
    _recognizer.dispose();
  }

  @override
  void initState() {
    super.initState();
    _viewModel = SupportCenterModel(widget.id);
    _viewModel.init();
    //客服点击
//    _recognizer.onTap = () => Navigator.pushNamed(context, Routes.service);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      itemBuilder: (context, index) =>
          index == datas.length ? _buildFootView() : _buildItem(datas[index]),
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

  /// 人工客服
  _buildFootView() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 24, bottom: 10),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "没有找到解决办法？联系",
              style: TextStyle(
                  fontSize: 12, color: Color.fromARGB(255, 102, 102, 102)),
            ),
            TextSpan(
              text: "人工客服",
              recognizer: _recognizer,
              style: TextStyle(
                  fontSize: 12, color: Color.fromARGB(255, 21, 139, 244)),
            ),
            TextSpan(
              text: "解决",
              style: TextStyle(
                  fontSize: 12, color: Color.fromARGB(255, 102, 102, 102)),
            ),
          ],
        ),
      ),
    );
  }

  _itemClick(SupportItemBean data) {
//    if (data.contextType == 1) {
//      Navigator.pushNamed(context, Routes.supportDetails,
//          arguments: {SupportDetailsPage.KEY_ID, data.id});
//    } else if (data.contextType == 2) {
//      Navigator.pushNamed(context, Routes.webPage);
//    }

//    XWebUtils.startNormalH5ForResult(activity, XCategory.CategoryVenturePlan.setTitle(title).setUrl(helpCenterQuestionListBean.linkUrl),
//    0, " kk_hybrid", "online_service", R.mipmap.ic_custom_service, null)
  }

  Widget _buildItem(SupportItemBean data) {
    return InkWell(
      onTap: _itemClick(data),
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
