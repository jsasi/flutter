import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshHead extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      builder: (BuildContext context, RefreshStatus mode) {
        Widget body;
        if (mode == RefreshStatus.idle) {
          body = Text("下拉刷新");
        } else if (mode == RefreshStatus.refreshing) {
          body = CircularProgressIndicator();
        } else if (mode == RefreshStatus.failed) {
          body = Text("下拉刷新失败");
        } else if (mode == RefreshStatus.canRefresh) {
          body = Text("松开手指刷新");
        } else if (mode == RefreshStatus.completed) {
          body = Text("刷新成功");
        } else {
          body = Text("未知");
        }
        return Container(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }

}
