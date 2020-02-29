import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:bw_sponsor_preferential/src/widgets/util.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

/// 画廊
class PhotoViewGalleryScreen extends StatefulWidget {
  static const KEY_FILES = "key_files";
  static const KEY_IMG_URLS = "key_img_urls";
  static const KEY_INDEX = "key_index";
  final arguments;

  PhotoViewGalleryScreen({Key key, this.arguments}) : super(key: key);

  @override
  _PhotoViewGalleryScreenState createState() => _PhotoViewGalleryScreenState();
}

class _PhotoViewGalleryScreenState extends State<PhotoViewGalleryScreen>
    with SingleTickerProviderStateMixin {
  List<File> _files = [];
  List<String> _imgUrls = [];
  int index = 0;
  String heroTag;
  PageController controller;

  int currentIndex = 0;

  //刷新下标stream
  var rebuildIndex = StreamController<int>.broadcast();
  AnimationController _animationController;
  Animation<double> _animation;
  Function animationListener;
  List<double> doubleTapScales = <double>[1.0, 2.0];

  GlobalKey<ExtendedImageSlidePageState> slidePagekey =
      GlobalKey<ExtendedImageSlidePageState>();

  // 解析路由数据
  void _initArguments() {
    if (widget.arguments != null) {
      _files.addAll(widget.arguments[PhotoViewGalleryScreen.KEY_FILES] ?? []);
      _imgUrls
          .addAll(widget.arguments[PhotoViewGalleryScreen.KEY_IMG_URLS] ?? []);
      index = widget.arguments[PhotoViewGalleryScreen.KEY_INDEX] ?? 0;
    }
  }

  @override
  void initState() {
    _initArguments();
    controller = PageController(initialPage: index);
    currentIndex = index;
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this);
    super.initState();
    currentIndex = index;
  }

  @override
  void dispose() {
    rebuildIndex.close();
    _animationController?.dispose();
    clearGestureDetailsCache();
    super.dispose();
  }

  // 弹出对话框
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
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
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
        Navigator.pop(context, _files.isNotEmpty ? _files : _imgUrls);
        return;
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          color: Colors.black,
          child: ExtendedImageGesturePageView.builder(
            itemBuilder: (BuildContext context, int index) {
              Widget image = _files.isNotEmpty
                  ? _buildImageFile(index, size)
                  : _buildImageNetwork(index, size);
              image = GestureDetector(
                child: image,
                onTap: () {
                  slidePagekey.currentState.popPage();
                  Navigator.pop(context);
                },
              );
              return image;
            },
            itemCount: _files.isNotEmpty ? _files.length : _imgUrls.length,
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

  Widget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(45),
      child: AppBar(
        backgroundColor: Colors.white12,
        leading: FlatButton(
          onPressed: () =>
              Navigator.pop(context, _files.isNotEmpty ? _files : _imgUrls),
          child: Icon(
            Icons.arrow_back,
            size: 24,
            color: Colors.white,
          ),
        ),
        title: StreamBuilder<int>(
          builder: (c, d) {
            return Text(
                "${currentIndex + 1}/${_files.isNotEmpty ? _files.length : _imgUrls.length}");
          },
          initialData: currentIndex,
          stream: rebuildIndex.stream,
        ),
        actions: <Widget>[
          if (_files.isNotEmpty)
            FlatButton(
              onPressed: () async {
                //弹出对话框并等待其关闭
                bool delete = await _showDeleteConfirmDialog();
                if (delete == null) {
                } else {
                  _files.removeAt(currentIndex);
                  if (_files.length == 0) {
                    Navigator.pop(context, _files);
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
    );
  }

  ExtendedImage _buildImageNetwork(int index, Size size) {
    return ExtendedImage.network(
      _imgUrls[index],
      fit: BoxFit.contain,
      enableSlideOutPage: true,
      mode: ExtendedImageMode.gesture,
      heroBuilderForSlidingPage: (Widget result) {
        if (index < min(9, _imgUrls.length)) {
          return Hero(
            tag: _imgUrls[index],
            child: result,
            flightShuttleBuilder: (BuildContext flightContext,
                Animation<double> animation,
                HeroFlightDirection flightDirection,
                BuildContext fromHeroContext,
                BuildContext toHeroContext) {
              final Hero hero = flightDirection == HeroFlightDirection.pop
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
              imageSize: Size(state.extendedImageInfo.image.width.toDouble(),
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
          state.handleDoubleTap(
              scale: _animation.value, doubleTapPosition: pointerDownPosition);
        };
        _animation =
            _animationController.drive(Tween<double>(begin: begin, end: end));

        _animation.addListener(animationListener);

        _animationController.forward();
      },
    );
  }

  ExtendedImage _buildImageFile(int index, Size size) {
    return ExtendedImage.file(
      _files[index],
      fit: BoxFit.contain,
      enableSlideOutPage: true,
      mode: ExtendedImageMode.gesture,
      heroBuilderForSlidingPage: (Widget result) {
        if (index < min(9, _files.length)) {
          return Hero(
            tag: _files[index].path,
            child: result,
            flightShuttleBuilder: (BuildContext flightContext,
                Animation<double> animation,
                HeroFlightDirection flightDirection,
                BuildContext fromHeroContext,
                BuildContext toHeroContext) {
              final Hero hero = flightDirection == HeroFlightDirection.pop
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
              imageSize: Size(state.extendedImageInfo.image.width.toDouble(),
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
          state.handleDoubleTap(
              scale: _animation.value, doubleTapPosition: pointerDownPosition);
        };
        _animation =
            _animationController.drive(Tween<double>(begin: begin, end: end));

        _animation.addListener(animationListener);

        _animationController.forward();
      },
    );
  }
}
