import 'package:flutter/material.dart';

import '../../common/page_status.dart';
import '../model/discount_entity.dart';


/// 优惠列表
class DiscountModel extends ChangeNotifier {
  ScreenStatus _screenStatus = ScreenStatus.Loading;

  ScreenStatus get screenStatus => _screenStatus;

  List<DiscountItemBean> _results = List();

  List<DiscountItemBean> get results => _results;

  DiscountModel();

  bool isInit = true;

  void loadMore() async {
    await Future.delayed(Duration(seconds: 1));
    for (var i = 0; i < 5; i++) {
      _results.add(DiscountItemBean(appListPicture:"http://img.bwhou2028.com/1581429316884091.jpg",activityStartTime: "2019/12/31",activityEndTime: "2019/01/01 至 2019/12/31",activityTag:"${_results.length%4}" ));
    }
    _screenStatus = ScreenStatus.LoadMoreComplete;
    if (_results.length > 20) {
      _screenStatus = ScreenStatus.LoadMoreNoData;
    }
    notifyListeners();
  }

  int num = 0;

  void refresh() async {
    await Future.delayed(Duration(seconds: 2));
    _results.clear();
    if (num == 4) {
      _screenStatus = ScreenStatus.Empty;
    } else if (num == 0) {
      _screenStatus = ScreenStatus.Error;
    } else {
      for (var i = 0; i < 5; i++) {
        _results.add(DiscountItemBean(appListPicture:"http://img.bwhou2028.com/1581429316884091.jpg",activityStartTime: "2019/12/31",activityEndTime: "2019/01/01 至 2019/12/31",activityTag:"${_results.length%4}" ));
      }
      _screenStatus = ScreenStatus.RefreshComplete;
    }
    num++;
    notifyListeners();
  }

  void init() async {
    _screenStatus = ScreenStatus.Loading;
    notifyListeners();
    refresh();
  }
}
