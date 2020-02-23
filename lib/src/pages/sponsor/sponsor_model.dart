import 'package:biz_app_init/biz_app_init.dart';
import 'package:bw_sponsor_preferential/src/model/api_service.dart';
import 'package:bw_sponsor_preferential/src/model/sponsor_entity.dart';
import 'package:flutter/material.dart';

import '../../common/page_status.dart';

/// 优惠列表
class SponsorModel extends ChangeNotifier {
  ScreenStatus _screenStatus = ScreenStatus.Loading;

  ScreenStatus get screenStatus => _screenStatus;

  List<SponorItemBean> _results = List();

  List<SponorItemBean> get results => _results;

  SponsorModel();

  int pageNum = 1;

  void loadMore() async {
    var spoList = await ApiService.getSpoList(pageNum: pageNum);
    if (spoList.code == 0) {
      if (spoList.data.list.isNotEmpty) {
        pageNum++;
        _results.addAll(spoList.data.list);
        _screenStatus = ScreenStatus.LoadMoreComplete;
      } else {
        _screenStatus = ScreenStatus.LoadMoreNoData;
      }
    } else {
      _screenStatus = ScreenStatus.LoadMoreFail;
    }
    notifyListeners();
  }

  void refresh() async {
    pageNum = 1;
    var spoList = await ApiService.getSpoList();
    if (spoList.code == 0) {
      _results.clear();
      if (spoList.data.list.isNotEmpty) {
        pageNum++;
        _results.addAll(spoList.data.list);
        _screenStatus = ScreenStatus.RefreshComplete;
      } else {
        _screenStatus = ScreenStatus.Empty;
      }
    } else {
      _screenStatus = ScreenStatus.Error;
    }

    notifyListeners();
  }

  void init() async {
    _screenStatus = ScreenStatus.Loading;
    notifyListeners();
    await appInit.initialize();
    refresh();
  }
}
