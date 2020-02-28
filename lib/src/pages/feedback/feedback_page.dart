import 'dart:async';
import 'dart:io';

import 'package:bw_res/bw_res.dart';
import 'package:bw_sponsor_preferential/bw_sponsor_preferential.dart';
import 'package:bw_sponsor_preferential/src/model/api_service.dart';
import 'package:bw_sponsor_preferential/src/model/fee_que_type_entity.dart';
import 'package:bw_sponsor_preferential/src/model/feedback_add_entity.dart';
import 'package:bw_sponsor_preferential/src/model/multi_upload_entity.dart';
import 'package:bw_sponsor_preferential/src/pages/feedback/feedback_res_utils.dart';
import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:bw_sponsor_preferential/src/widgets/photo_gallery_page.dart';
import 'package:bw_sponsor_preferential/src/widgets/simple_imageview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';

class FeedbackPage extends StatefulWidget {
  FeedbackPage({Key key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  // 输入框监听
  TextEditingController _inputController = new TextEditingController();

  // 控制提交按钮是否可点击的通知
  final StreamController<bool> _streamSubmitController =
      StreamController<bool>();

  // 控制提交按钮是否可点击的通知
  final StreamController<bool> _streamImgController = StreamController<bool>();

  //提交按钮是否可点击
  bool _enableSubmit = false;

  //所有问题类型
  List<FeeQueTypeItemBean> types = new List();

  //记录选择问题类型
  FeeQueTypeItemBean _selectTypeBean;

  //记录选择图片
  List<File> _images = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  /// 获取意见反馈问题列表
  _loadTypeList() async {
    FeeQueTypeEntity entity = await ApiService.getFeeTypeList();
    if (entity.code == 0 && entity.data != null && entity.data.isNotEmpty) {
      types = entity.data;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadTypeList();
    _addInputListener();
  }

  /// 输入大于等于20个字按钮可以点击
  void _addInputListener() {
    _inputController.addListener(() {
      _enableSubmit = _inputController.text.trim().toString().length > 19;
      _streamSubmitController.sink.add(_enableSubmit);
    });
  }

  @override
  void dispose() {
    _streamSubmitController.close();
    _streamImgController.close();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: DssAppBar(
        Strings.feeTitle,
        hideLeftArrow: false,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 14, top: 20, bottom: 10),
          child: Text(
            Strings.feeQuestionType,
            style: TextStyle(fontSize: 14, color: BWColors.disItemTitle),
          ),
        ),
        _buildSelQuestionLayout(),
        Container(
          padding: EdgeInsets.only(left: 14, top: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                Strings.feeQuestionDesv,
                style: TextStyle(fontSize: 14, color: BWColors.disItemTitle),
              ),
              Text(
                Strings.feeQuestionTips,
                style: TextStyle(fontSize: 12, color: BWColors.dssDesc),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 14),
          child: TextFormField(
              maxLines: 8,
              maxLength: 200,
              maxLengthEnforced: true,
              controller: _inputController,
              style: TextStyle(fontSize: 14, color: BWColors.feeInputText),
              decoration: InputDecoration(
                // 去掉下划线
                border: InputBorder.none,
                hintText: Strings.feeQuestionInputHint,
                hintStyle: TextStyle(fontSize: 14, color: BWColors.dssDesc),
              ),
              obscureText: false,
              //校验密码
              validator: (v) {
                return v.trim().length > 19 ? null : "密码不能少于20位";
              }),
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 0),
          child: Divider(
            height: 1,
            color: BWColors.dssDivider,
          ),
        ),
        Container(
          height: 90,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 14),
          color: Colors.white,
          child: StreamBuilder(
            initialData: false,
            stream: _streamImgController.stream,
            builder: (context, snapshot) {
              return Row(
                children: <Widget>[
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      //禁用滑动事件
                      scrollDirection: Axis.horizontal,
                      itemCount: _images.length < 3 ? _images.length + 1 : 3,
                      itemBuilder: (context, index) {
                        return _buildSelImageItem(index);
                      }),
                  Expanded(
                      child: Container(
                          alignment: Alignment.topRight,
                          child: Text(
                            '${_images.length}/3',
                            style: TextStyle(
                                fontSize: 12, color: BWColors.dssDesc),
                          ))),
                ],
              );
            },
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          padding: EdgeInsets.only(left: 14, bottom: 10),
          child: Text(
            Strings.feeQuestionImgTips,
            style: TextStyle(fontSize: 12, color: BWColors.dssDesc),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 45,
            child: StreamBuilder<bool>(
                stream: _streamSubmitController.stream,
                initialData: false,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  return FlatButton(
                    onPressed: snapshot.data ? _trySubmit : null,
                    color: BWColors.dssBtnBg,
                    disabledColor: BWColors.dssBtnDisabledBg,
                    child: Text(
                      Strings.submit,
                      style:
                          TextStyle(fontSize: 16, color: BWColors.dssBtnText),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }

  /// 选择问题分类
  InkWell _buildSelQuestionLayout() {
    return InkWell(
      onTap: () => _showQuestDialog(),
      child: Container(
        padding: EdgeInsets.only(left: 14, right: 14),
        height: 50,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            if (_selectTypeBean != null) ...{
              SimpleImageView.assetImage(
                  FeedbackResUtils.getResIdByCode(_selectTypeBean.code),
                  width: 32,
                  height: 32),
              Expanded(
                child: Text(
                  _selectTypeBean.dictValue,
                  style: TextStyle(
                      fontSize: 14, color: BWColors.dssTitleLeftArrow),
                ),
              ),
              Icon(
                CupertinoIcons.forward,
                size: 14,
                color: BWColors.dssDesc,
              )
            } else ...{
              Text(
                Strings.feeSelectTitle,
                style: TextStyle(fontSize: 16, color: BWColors.dssDesc),
              ),
              Icon(
                CupertinoIcons.forward,
                size: 14,
                color: BWColors.dssDesc,
              )
            }
          ],
        ),
      ),
    );
  }

  /// 选择照片布局
  Widget _buildSelImageItem(int index) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: InkWell(
              onTap: index < _images.length
                  ? () => _previewPhoto(index)
                  : _showTakePhotoDialog,
              child: index < _images.length
                  ? Image.file(
                      _images[index],
                      width: 50,
                      height: 50,
                      fit: BoxFit.fill,
                    )
                  : SimpleImageView.assetImage(R.fee_select_img_add,
                      width: 50, height: 50)),
        ),
        if (index < _images.length)
          Positioned(
            left: 42,
            bottom: 42,
            child: InkWell(
              onTap: () => _delImg(index),
              child: SimpleImageView.assetImage(
                R.fee_select_img_del,
                width: 16,
                height: 16,
              ),
            ),
          )
      ],
    );
  }

  /// 选择照片弹框
  _showTakePhotoDialog() {
    // 弹出底部菜单列表模态对话框
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  _openGallery();
                },
                child: _buildPhotoDialogItem(Strings.photo_album)),
            Container(
              color: Colors.white,
              child: Divider(
                height: 1,
                color: BWColors.dssDivider,
              ),
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  _takePhoto();
                },
                child: _buildPhotoDialogItem(Strings.photograph)),
            Container(
              height: 10,
              color: BWColors.dssPageBg,
            ),
            InkWell(
                onTap: () => Navigator.pop(context),
                child: _buildPhotoDialogItem(Strings.cancel)),
          ],
        );
      },
    );
  }

  /// 选择照片item
  Widget _buildPhotoDialogItem(String title) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Text(
        title,
        style: TextStyle(fontSize: 18, color: BWColors.dssTitleLeftArrow),
      ),
    );
  }

  /// 选择问题类型弹框
  _showQuestDialog() {
    if (types.isEmpty) {
      _loadTypeList();
      return;
    }
    // 弹出底部菜单列表模态对话框
    showModalBottomSheet<FeeQueTypeItemBean>(
        isScrollControlled: true,
        context: context,
        builder: (context) => _buildBottomSheet()).then((bean) {
      if (null != bean) {
        _selectTypeBean = bean;
        setState(() {
          print('============setState');
        });
      }
    });
  }

  /// 选择问题类型弹窗布局
  Column _buildBottomSheet() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        _buildItemHead(),
        Container(
          height: 10,
          color: BWColors.dssPageBg,
        ),
        ListView.separated(
            shrinkWrap: true,
            itemCount: types.length,
            //分割器构造器
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                color: Colors.white,
                child: Divider(
                  height: 1,
                  indent: 14,
                  color: BWColors.dssDivider,
                ),
              );
            },
            itemBuilder: _buildItem),
      ],
    );
  }

  /// 选择问题类型弹窗item
  Widget _buildItem(context, index) {
    var bean = types[index];
    return Container(
      color: Colors.white,
      height: 50,
      padding: EdgeInsets.only(left: 14, right: 14),
      child: InkWell(
        onTap: () => Navigator.pop(context, bean),
        child: Row(
          children: <Widget>[
            SimpleImageView.assetImage(
                FeedbackResUtils.getResIdByCode(bean.code),
                width: 32,
                height: 32),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  bean.dictValue,
                  style: TextStyle(fontSize: 14, color: BWColors.disItemTitle),
                ),
              ),
            ),
            if ((_selectTypeBean == null && index == 0) ||
                (_selectTypeBean != null && bean.code == _selectTypeBean.code))
              Icon(
                Icons.check,
                size: 16,
                color: Colors.blue,
              ),
          ],
        ),
      ),
    );
  }

  /// 选择问题类型弹框头部
  _buildItemHead() {
    return Container(
      height: 73,
      padding: EdgeInsets.only(left: 14, right: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            Strings.cancel,
            style: TextStyle(
                fontSize: 16, color: Color.fromARGB(255, 21, 139, 244)),
          ),
          Text(
            Strings.feeSelectTitle,
            style: TextStyle(fontSize: 16, color: BWColors.disItemTitle),
          ),
          Container(),
        ],
      ),
    );
  }

  ///相册
  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (mounted && image != null) {
      _images.add(image);
      _streamImgController.sink.add(true);
    }
  }

  /// 拍照
  _takePhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (mounted && image != null) {
      _images.add(image);
      _streamImgController.sink.add(true);
    }
  }

  _trySubmit() {
    if (_selectTypeBean != null) {
      _submit();
    } else {
      showToast(Strings.feePleaseSelectTitle);
    }
  }

  _submit() async {
    String imgUrls;
    if (_images.isNotEmpty) {
      var entity = await ApiService.uploadFeeFiles(_images);
      if (entity.code != 0) {
        showToast(entity.msg);
        return;
      }
      var sb = StringBuffer();
      entity?.data?.forEach((bean) {
        sb.write("${bean.fileUrl},");
      });
      var urls = sb.toString();
      if (sb.length > 0) imgUrls = urls.substring(0, urls.length - 1);
      sb.clear();
      debugPrint('==========imgUrls============$imgUrls');
      FeedbackAddEntity feedbackAddEntity = await ApiService.addFeeback(
          _selectTypeBean.code,
          _selectTypeBean.dictValue,
          _inputController.text.trim().toString(),
          imgUrls);
      if (feedbackAddEntity.code == 0) {
        Navigator.of(context).popAndPushNamed(Routes.feedbackList);
      } else {
        showToast(feedbackAddEntity.msg ?? '');
      }
    }
  }

  /// 删除照片
  _delImg(int index) {
    if (mounted && _images.length > index) {
      setState(() {});
      _images.removeAt(index);
      _streamImgController.sink.add(true);
    }
  }

  _previewPhoto(int index) async {
    final result =
        await Navigator.of(context).pushNamed(Routes.photoGallery, arguments: {
      PhotoViewGalleryScreen.KEY_IMAGES: _images,
      PhotoViewGalleryScreen.KEY_INDEX: index
    });
    if (mounted) {
      _images = result;
      _streamImgController.sink.add(true);
    }
  }
}
