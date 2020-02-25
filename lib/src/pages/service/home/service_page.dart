import 'package:bw_res/bw_res.dart';
import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_sponsor_preferential/src/model/service_entity.dart';
import 'package:bw_sponsor_preferential/src/pages/service/home/service_model.dart';
import 'package:bw_sponsor_preferential/src/pages/service/support/support_center_page.dart';
import 'package:bw_sponsor_preferential/src/widgets/service_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../common/page_status.dart';
import '../../../routers/routes.dart';
import '../../../widgets/empty_view_.dart';
import '../../../widgets/net_error_view.dart';

/// 客服页面
class SevicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            Strings.serTitle,
            style: TextStyle(fontSize: 16, color: BWColors.serviceTitle),
          ),
          actions: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  Strings.feeTitle,
                  style: TextStyle(fontSize: 14, color: BWColors.serviceTitle),
                ),
              ),
            )
          ],
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

  final viewModel = ServiceModel();

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
    return ChangeNotifierProvider<ServiceModel>.value(
      value: viewModel,
      child: Consumer<ServiceModel>(builder: (context, vm, child) {
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
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 14, top: 8, bottom: 8),
          color: BWColors.serviceBg,
          child: Text(
            Strings.serGuess,
            style: TextStyle(fontSize: 16, color: BWColors.serviceTitle),
          ),
        ),
        Expanded(
          child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              onRefresh: () => viewModel.refresh(),
              controller: _refreshController,
              child: _buideList(viewModel.results)),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 28),
          height: 76,
          color: BWColors.serviceBg,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(right: 10),
                height: 46,
                child: FlatButton(
                  color: BWColors.dssBtnBg,
                  child: Text(
                    Strings.serMain,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  onPressed: () {},
                ),
              )),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 46,
                  child: FlatButton(
                    child: Text(
                      Strings.serSecond,
                      style:
                          TextStyle(color: BWColors.dssBtnBg, fontSize: 16),
                    ),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: BWColors.dssBtnBg,
                        ),
                        borderRadius: BorderRadius.circular(4.0)),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 数据页面
  /// [datas] 展示数据列表
  ListView _buideList(List<ServiceItemBean> datas) {
    return ListView.separated(
      itemCount: datas.length,
      itemBuilder: (context, index) => InkWell(
          onTap: () => Navigator.pushNamed(context, Routes.supportCenter,
              arguments: {SupportCenterListPage.KEY_DATA: datas[index]}),
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
