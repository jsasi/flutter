import 'package:biz_app_init/biz_app_init.dart';
import 'package:bw_sponsor_preferential/src/model/api_service.dart';
import 'package:bw_sponsor_preferential/src/model/discount_entity.dart';
import 'package:flutter/material.dart';

import '../../common/page_status.dart';


/// 优惠列表
class DiscountModel extends ChangeNotifier {
  ScreenStatus _screenStatus = ScreenStatus.Loading;

  ScreenStatus get screenStatus => _screenStatus;

  List<DiscountItemBean> _results = List();

  List<DiscountItemBean> get results => _results;

  DiscountModel();

  bool isInit = true;

  void loadMore() async {
    var disList = await ApiService.getDisList(pageNum: pageNum);
    if (disList.code == 0) {
      if (disList.data.list.isNotEmpty) {
        pageNum++;
        _results.addAll(disList.data.list);
        _screenStatus = ScreenStatus.LoadMoreComplete;
      } else {
        _screenStatus = ScreenStatus.LoadMoreNoData;
      }
    } else {
      _screenStatus = ScreenStatus.LoadMoreFail;
    }
    notifyListeners();
  }

  int pageNum = 1;
  void refresh() async {
    pageNum = 1;
    var disList = await ApiService.getDisList();
    if (disList.code == 0) {
      _results.clear();
      if (disList.data.list.isNotEmpty) {
        pageNum++;
        _results.addAll(disList.data.list);
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
