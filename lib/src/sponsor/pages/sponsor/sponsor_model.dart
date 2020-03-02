import 'package:bw_sponsor_preferential/src/common/page_status.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/api_service.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/sponsor_entity.dart';
import 'package:flutter/material.dart';


/// 赞助列表
class SponsorModel extends ChangeNotifier {
  ScreenStatus _screenStatus = ScreenStatus.Loading;

  ScreenStatus get screenStatus => _screenStatus;

  List<SponorItemBean> _results = List();

  List<SponorItemBean> get results => _results;

  SponsorModel();

  int pageNum = 1;

  void loadMore() async {
    var entity = await ApiService.getSpoList(pageNum: pageNum);
    if (entity.code == 0) {
      if (entity.data.list.isNotEmpty) {
        pageNum++;
        _results.addAll(entity.data.list);
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
    var entity = await ApiService.getSpoList();
    if (entity.code == 0) {
      _results.clear();
      if (entity.data.list.isNotEmpty) {
        pageNum++;
        _results.addAll(entity.data.list);
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
    refresh();
  }
}
