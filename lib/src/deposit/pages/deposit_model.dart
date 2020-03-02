import 'package:bw_sponsor_preferential/src/common/page_status.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/api_service.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/discount_entity.dart';
import 'package:flutter/material.dart';

class DepositModel extends ChangeNotifier {
  ScreenStatus _screenStatus = ScreenStatus.Loading;

  ScreenStatus get screenStatus => _screenStatus;

  List<DiscountItemBean> _results = List();

  List<DiscountItemBean> get results => _results;

  DepositModel();

  bool isInit = true;

  void loadMore() async {
    var entity = await ApiService.getDisList(pageNum: pageNum);
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

  int pageNum = 1;

  void refresh() async {
    pageNum = 1;
    var entity = await ApiService.getDisList();
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

/// 判断标题栏是否显示帮助图标
class TitleModel with ChangeNotifier {
  bool isShowHelpIcon = false;

  void getHelpList() async {
    var entity = await ApiService.getSerHelpList();
    if (entity.code == 0 && entity.data.isNotEmpty) {
      isShowHelpIcon = true;
    } else {
      isShowHelpIcon = false;
    }
    notifyListeners();
  }
}
