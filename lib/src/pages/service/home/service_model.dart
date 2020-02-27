import 'package:bw_sponsor_preferential/src/common/page_status.dart';
import 'package:bw_sponsor_preferential/src/model/api_service.dart';
import 'package:bw_sponsor_preferential/src/model/service_entity.dart';
import 'package:bw_sponsor_preferential/src/model/sponsor_entity.dart';
import 'package:flutter/material.dart';

/// 优惠列表
class ServiceModel extends ChangeNotifier {
  ScreenStatus _screenStatus = ScreenStatus.Loading;

  ScreenStatus get screenStatus => _screenStatus;

  List<ServiceItemBean> _results = List();

  List<ServiceItemBean> get results => _results;

  ServiceModel();

  void refresh() async {
    var entity = await ApiService.getSerHelpList();
    if (entity.code == 0) {
      _results.clear();
      if (entity.data.isNotEmpty) {
        _results.addAll(entity.data);
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
