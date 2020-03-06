import 'dart:async';

import 'package:bw_res/bw_res.dart';
import 'package:bw_sponsor_preferential/src/deposit/model/deposit_notice_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DepositMarqueen extends StatefulWidget {
  final double height;
  List<NoticeEntry> data;

  DepositMarqueen({this.height, this.data, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DepositMarqueenState();
  }
}

class _DepositMarqueenState extends State<DepositMarqueen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;
  Timer _timer;

  GlobalKey _textContentKey = GlobalKey(debugLabel: "text");
  GlobalKey _scrollKey = GlobalKey(debugLabel: "scroll");
  double _textContentWidth = 0; // 文本宽度
  double _minTextWidth = 2;
  double _scrollWidth = 0; // 文本UI宽度

  @override
  void initState() {
    _textContentWidth = 0;
    _scrollWidth = 0;
    super.initState();
  }

  void startAnimation(double textWidth, double scrollWidth) {
    if (textWidth < scrollWidth) {
      return;
    }

    double rates = 12000; //动画速率（一屏幕宽度12秒）
    double animSeconds =
        (textWidth / (MediaQuery.of(context).size.width - 80)) * rates;
    int seconds = animSeconds ~/ 1000; // 动画时长

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: seconds));
    _animation = Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-0.97, 0.0))
        .animate(_controller);

    _animation.addListener(() {
      if (mounted && _textContentWidth == 0) {
        double width = _textContentKey.currentContext.size.width;
        _textContentWidth = width;
      }
      setState(() {});
    });

    _controller.repeat();
  }

  // 获取文本的宽度，宽度信息并保存到widget的_textSizeInfo
  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_textContentWidth <= _minTextWidth &&
          _textContentKey.currentContext != null) {
        if (mounted && _textContentWidth == 0) {
          double width = _textContentKey.currentContext.size.width;
          double scrollWidth = _scrollKey.currentContext.size.width;
          _textContentWidth = width;
          _scrollWidth = scrollWidth;
          _timer.cancel();
          startAnimation(_textContentWidth, _scrollWidth);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 236, 238, 242),
      ),
      height: widget.height,
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 6),
          ),
          Expanded(
            child: _marqueeWidget(),
          ),
        ],
      ),
    );
  }

  Widget _marqueeWidget() {
    return Container(
      child: ClipRect(
        child: SingleChildScrollView(
          key: _scrollKey,
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          child: Center(
            child: FractionalTranslation(
              translation: _animation?.value ?? Offset(0, 0),
              child: _noticeContentWidget(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _noticeContentWidget() {
    List<Widget> widgets = [];

    for (int i = 0; i < widget.data.length; i++) {
      NoticeEntry entity = widget.data[i];
      if (entity.content is String) {
        GestureDetector gestureDetector = GestureDetector(
          onTap: () {},
          child: Text(
            entity.content,
            style: TextStyle(
              fontSize: 12,
              color: BWColors.dssDesc,
            ),
            maxLines: 1,
          ),
        );

        widgets.add(gestureDetector);
        widgets.add(Padding(padding: EdgeInsets.only(right: 10)));
      } else {
        debugPrint("公告 内容异常");
      }
    }

    if (widgets.length == 0) {
      return Container(
        width: _minTextWidth,
        height: widget.height,
      );
    } else {
      return Container(
        key: _textContentKey,
        child: Row(
          children: widgets,
        ),
      );
    }
  }

  // AnimatedPositioned
  @override
  void dispose() {
    _controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
