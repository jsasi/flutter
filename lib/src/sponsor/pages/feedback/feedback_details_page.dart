import 'package:biz_login/biz_login.dart';
import 'package:bw_base/bw_base.dart';
import 'package:bw_res/bw_res.dart';
import 'package:bw_sponsor_preferential/bw_sponsor_preferential.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/api_service.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/feedback_details_entity.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/feedback/feedback_res_utils.dart';
import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:bw_sponsor_preferential/src/widgets/net_error_view.dart';
import 'package:bw_sponsor_preferential/src/widgets/photo_gallery_page.dart';
import 'package:bw_sponsor_preferential/src/widgets/simple_imageview.dart';
import 'package:bw_utils/bw_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 意见反馈详情
class FeedbackDetailsPage extends StatefulWidget {
  FeedbackDetailsPage({Key key, @required this.id}) : super(key: key);
  final  int id;

  @override
  _FeedbackDetailsPageState createState() {
    return _FeedbackDetailsPageState();
  }
}

class _FeedbackDetailsPageState extends State<FeedbackDetailsPage> {

  FeedbackDetailsBean _bean;

  //获取过数据
  bool isInited = false;

  /// 获取意见反馈问详情
  _loadDetails() async {
    FeedbackDetailsEntity entity = await ApiService.getFeedbackDetails(widget.id);
    if (entity.code == 0 && entity.data != null) {
      _bean = entity.data;
    }
    setState(() {
      isInited = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadDetails();
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DssAppBar(
          Strings.feeDetailsTitle,
          hideLeftArrow: false,
        ),
        body: _buildStatsBody());
  }

  Widget _buildStatsBody() {
    if (_bean == null && isInited) {
      return NetErrorView();
    } else if (_bean == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return _buildBody();
    }
  }

  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(top: 9, right: 14),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 19),
                child: SimpleImageView.assetImage(
                    FeedbackResUtils.getResIdByCode(_bean.id.toString())),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  _bean.description,
                  style: TextStyle(fontSize: 14, color: BWColors.dssItemTitle),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 9, bottom: 18),
            child: Divider(
              height: 1,
              color: BWColors.dssDivider,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 19),
            child: Row(
              children: <Widget>[
                ClipOval(
                    child: SizedBox(
                        width: 28,
                        height: 28,
                        child: SimpleImageView.displayIcon(
                            LoginUtil.getUserEntity()?.avatar ?? ""))),
                Padding(
                  padding: EdgeInsets.only(left: 7),
                  child: Text(bwManager.mainUserName),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 54, bottom: 10),
            child: Text(_bean.content),
          ),
          if (!StringUtil.isNullOrEmpty(_bean.picUrls))
            Padding(
              padding: const EdgeInsets.only(left: 54),
              child: Row(
                children: <Widget>[..._buildImageViewList()],
              ),
            ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 54, bottom: 10),
            child: Text(
              _bean.createdAt,
              style: TextStyle(fontSize: 10, color: BWColors.dssDesc),
            ),
          ),
          Divider(
            height: 1,
            color: BWColors.dssDivider,
            indent: 54,
          )
        ],
      ),
    );
  }

  List<Widget> _buildImageViewList() {
    var split = _bean.picUrls.split(",");
    return split.asMap().entries.map((entry) {
      int idx = entry.key;
      String url = entry.value;
      return InkWell(
        onTap: ()=>Navigator.pushNamed(context, SponsorPreferentialRoute.photoGallery,arguments: {PhotoViewGalleryScreen.KEY_IMG_URLS:split,PhotoViewGalleryScreen.KEY_INDEX:idx}),
        child: Padding(
          padding: EdgeInsets.only(right: 10, bottom: 10),
          child: SimpleImageView.display(url, width: 50, height: 50),
        ),
      );
    }).toList();
  }
}
