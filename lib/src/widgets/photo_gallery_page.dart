import 'dart:io';

import 'package:bw_utils/bw_utils.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

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

class _PhotoViewGalleryScreenState extends State<PhotoViewGalleryScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
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
            title: Text("${currentIndex + 1}/${widget.images.length}"),
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
              )
            ],
          ),
        ),
        body: Container(
            child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: FileImage(widget.images[index]),
              heroAttributes: !StringUtil.isNullOrEmpty(widget.heroTag)
                  ? PhotoViewHeroAttributes(tag: widget.heroTag)
                  : null,
            );
          },
          itemCount: widget.images.length,
          loadingChild: Container(),
          backgroundDecoration: null,
          pageController: widget.controller,
          enableRotation: true,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        )),
      ),
    );
  }
}
