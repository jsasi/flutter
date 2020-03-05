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
  final List<File> files ;
  final List<String> imgUrls;
  int index = 0;
  PhotoViewGalleryScreen({Key key, this.files,this.imgUrls,this.index}) : super(key: key);

  @override
  _PhotoViewGalleryScreenState createState() => _PhotoViewGalleryScreenState();
}

class _PhotoViewGalleryScreenState extends State<PhotoViewGalleryScreen>
    with SingleTickerProviderStateMixin {

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



  @override
  void initState() {
    controller = PageController(initialPage: widget.index);
    currentIndex = widget.index;
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this);
    super.initState();
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
        Navigator.pop(context, widget.imgUrls==null ? widget.files : widget.imgUrls);
        return;
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          color: Colors.black,
          child: ExtendedImageGesturePageView.builder(
            itemBuilder: (BuildContext context, int index) {
              Widget image = widget.imgUrls==null
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
            itemCount: widget.imgUrls==null ? widget.files.length : widget.imgUrls.length,
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
              Navigator.pop(context, widget.imgUrls==null?  widget.files :  widget.imgUrls),
          child: Icon(
            Icons.arrow_back,
            size: 24,
            color: Colors.white,
          ),
        ),
        title: StreamBuilder<int>(
          builder: (c, d) {
            return Text(
                "${currentIndex + 1}/${widget.imgUrls==null? widget.files.length : widget.imgUrls.length}");
          },
          initialData: currentIndex,
          stream: rebuildIndex.stream,
        ),
        actions: <Widget>[
          if (widget.imgUrls==null)
            FlatButton(
              onPressed: () async {
                //弹出对话框并等待其关闭
                bool delete = await _showDeleteConfirmDialog();
                if (delete == null) {
                } else {
                  widget.files.removeAt(currentIndex);
                  if (widget.files.length == 0) {
                    Navigator.pop(context, widget.files);
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
      widget.imgUrls[index],
      fit: BoxFit.contain,
      enableSlideOutPage: true,
      mode: ExtendedImageMode.gesture,
      heroBuilderForSlidingPage: (Widget result) {
        if (index < min(9, widget.imgUrls.length)) {
          return Hero(
            tag: widget.imgUrls[index],
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
      widget.files[index],
      fit: BoxFit.contain,
      enableSlideOutPage: true,
      mode: ExtendedImageMode.gesture,
      heroBuilderForSlidingPage: (Widget result) {
        if (index < min(9, widget.files.length)) {
          return Hero(
            tag: widget.files[index].path,
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
