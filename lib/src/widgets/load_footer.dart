import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LoadFooter extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context,LoadStatus mode){
        Widget body ;
        if(mode==LoadStatus.idle){
          body =  Text("上拉加载更多");
        }
        else if(mode==LoadStatus.loading){
          body =  CircularProgressIndicator();
        }
        else if(mode == LoadStatus.failed){
          body = Text("加载更多失败");
        }
        else if(mode == LoadStatus.canLoading){
          body = Text("松开加载更多");
        }
        else{
          body = Text("没有更多了");
        }
        return Container(
          height: 55.0,
          child: Center(child:body),
        );
      },
    );
  }

}
