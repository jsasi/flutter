import 'package:biz_app_init/biz_app_init.dart';
import 'package:bw_sponsor_preferential/src/common/page_status.dart';
import 'package:bw_sponsor_preferential/src/model/api_service.dart';
import 'package:bw_sponsor_preferential/src/model/service_entity.dart';
import 'package:bw_sponsor_preferential/src/model/sponsor_entity.dart';
import 'package:bw_sponsor_preferential/src/model/support_type_entity.dart';
import 'package:flutter/material.dart';

/// 客服分类列表
class SupportCenterModel extends ChangeNotifier {
  ScreenStatus _screenStatus = ScreenStatus.Loading;

  ScreenStatus get screenStatus => _screenStatus;

  List<SupportItemBean> _results = List();

  List<SupportItemBean> get results => _results;

  SupportCenterModel(this._helpCateId);

  final int _helpCateId;

  void refresh() async {
    var entity = await ApiService.getSupTypeList(_helpCateId);
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
