import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:bw_sponsor_preferential/src/widgets/util.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class PhotoViewGalleryScreen extends StatefulWidget {
  List<File> images = [];
  int index = 0;
  String heroTag;
  PageController controller;
  final arguments;

  static const KEY_IMAGES = "key_images";
  static const KEY_INDEX = "key_index";

  PhotoViewGalleryScreen({Key key, this.arguments}) : super(key: key) {
    _initArguments();
    controller = PageController(initialPage: index);
  }

  // 解析路由数据
  void _initArguments() {
    if (arguments != null) {
      images = arguments[KEY_IMAGES];
      index = arguments[KEY_INDEX];
    }
  }

  @override
  _PhotoViewGalleryScreenState createState() => _PhotoViewGalleryScreenState();
}

class _PhotoViewGalleryScreenState extends State<PhotoViewGalleryScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  var rebuildIndex = StreamController<int>.broadcast();
  AnimationController _animationController;
  Animation<double> _animation;
  Function animationListener;

  List<double> doubleTapScales = <double>[1.0, 2.0];
  GlobalKey<ExtendedImageSlidePageState> slidePagekey =
      GlobalKey<ExtendedImageSlidePageState>();

  @override
  void initState() {
    currentIndex = widget.index;
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this);
    super.initState();
    currentIndex = widget.index;
  }

  @override
  void dispose() {
    rebuildIndex.close();
    _animationController?.dispose();
    clearGestureDetailsCache();
    super.dispose();
  } // 弹出对话框

  Future<bool> _showDeleteConfirmDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要删除这张照片吗?"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            FlatButton(
              child: Text("确定"),
              onPressed: () {
                Navigator.of(context).pop(true);
                //关闭对话框并返回true
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, widget.images);
        return;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: AppBar(
            backgroundColor: Colors.white12,
            leading: FlatButton(
              onPressed: () => Navigator.pop(context, widget.images),
              child: Icon(
                Icons.arrow_back,
                size: 24,
                color: Colors.white,
              ),
            ),
            title: StreamBuilder<int>(
              builder: (c, d) {
                return Text("${currentIndex + 1}/${widget.images.length}");
              },
              initialData: currentIndex,
              stream: rebuildIndex.stream,
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  //弹出对话框并等待其关闭
                  bool delete = await _showDeleteConfirmDialog();
                  if (delete == null) {
                  } else {
                    widget.images.removeAt(currentIndex);
                    if (widget.images.length == 0) {
                      Navigator.pop(context, widget.images);
                    } else {
                      setState(() {});
                    }
                  }
                },
                child: Icon(
                  Icons.delete,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.black,
          child: ExtendedImageGesturePageView.builder(
            itemBuilder: (BuildContext context, int index) {
              var file = widget.images[index];
              Widget image = ExtendedImage.file(
                file,
                fit: BoxFit.contain,
                enableSlideOutPage: true,
                mode: ExtendedImageMode.gesture,
                heroBuilderForSlidingPage: (Widget result) {
                  if (index < min(9, widget.images.length)) {
                    return Hero(
                      tag: file.path,
                      child: result,
                      flightShuttleBuilder: (BuildContext flightContext,
                          Animation<double> animation,
                          HeroFlightDirection flightDirection,
                          BuildContext fromHeroContext,
                          BuildContext toHeroContext) {
                        final Hero hero =
                            flightDirection == HeroFlightDirection.pop
                                ? fromHeroContext.widget
                                : toHeroContext.widget;
                        return hero.child;
                      },
                    );
                  } else {
                    return result;
                  }
                },
                initGestureConfigHandler: (state) {
                  double initialScale = 1.0;

                  if (state.extendedImageInfo != null &&
                      state.extendedImageInfo.image != null) {
                    initialScale = initScale(
                        size: size,
                        initialScale: initialScale,
                        imageSize: Size(
                            state.extendedImageInfo.image.width.toDouble(),
                            state.extendedImageInfo.image.height.toDouble()));
                  }
                  return GestureConfig(
                      inPageView: true,
                      initialScale: initialScale,
                      maxScale: max(initialScale, 5.0),
                      animationMaxScale: max(initialScale, 5.0),
                      initialAlignment: InitialAlignment.center,
                      //you can cache gesture state even though page view page change.
                      //remember call clearGestureDetailsCache() method at the right time.(for example,this page dispose)
                      cacheGesture: false);
                },
                onDoubleTap: (ExtendedImageGestureState state) {
                  ///you can use define pointerDownPosition as you can,
                  ///default value is double tap pointer down postion.
                  var pointerDownPosition = state.pointerDownPosition;
                  double begin = state.gestureDetails.totalScale;
                  double end;

                  //remove old
                  _animation?.removeListener(animationListener);

                  //stop pre
                  _animationController.stop();

                  //reset to use
                  _animationController.reset();

                  if (begin == doubleTapScales[0]) {
                    end = doubleTapScales[1];
                  } else {
                    end = doubleTapScales[0];
                  }

                  animationListener = () {
                    //print(_animation.value);
                    state.handleDoubleTap(
                        scale: _animation.value,
                        doubleTapPosition: pointerDownPosition);
                  };
                  _animation = _animationController
                      .drive(Tween<double>(begin: begin, end: end));

                  _animation.addListener(animationListener);

                  _animationController.forward();
                },
              );
              image = GestureDetector(
                child: image,
                onTap: () {
                  slidePagekey.currentState.popPage();
                  Navigator.pop(context);
                },
              );
              return image;
            },
            itemCount: widget.images.length,
            onPageChanged: (int index) {
              currentIndex = index;
              rebuildIndex.add(index);
            },
            controller: PageController(
              initialPage: currentIndex,
            ),
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
