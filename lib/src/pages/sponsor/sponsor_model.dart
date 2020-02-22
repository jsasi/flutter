import 'package:flutter/material.dart';

import '../../common/page_status.dart';
import '../model/sponsor_entity.dart';

/// 优惠列表
class SponsorModel extends ChangeNotifier {
  ScreenStatus _screenStatus = ScreenStatus.Loading;

  ScreenStatus get screenStatus => _screenStatus;

  List<SponsorEntity> _results = List();

  List<SponsorEntity> get results => _results;

  SponsorModel();

  bool isInit = true;

  void loadMore() async {
    await Future.delayed(Duration(seconds: 1));
    for (var i = 0; i < 5; i++) {
      _results.add(SponsorEntity(
          sponsoredIconUrl: "https://i.loli.net/2020/02/21/X852emob4ayEn1K.png",
          firstCreative: "拜仁慕尼黑",
          keyCreative: "查看专题详情",
          sponsoredUrl:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQfCHKp7ySDVfaS4RfGW10s6N56bMPhnFdjn52OZXJKVhtP_aCJ",
          secondCreative: "亚洲区赞助商"));
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
        _results.add(SponsorEntity(
            sponsoredIconUrl:
                "https://i.loli.net/2020/02/21/X852emob4ayEn1K.png",
            firstCreative: "拜仁慕尼黑",
            keyCreative: "查看专题详情",
            sponsoredUrl:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQfCHKp7ySDVfaS4RfGW10s6N56bMPhnFdjn52OZXJKVhtP_aCJ",
            secondCreative: "亚洲区赞助商"));
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
