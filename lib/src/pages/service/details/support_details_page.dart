import 'package:bw_sponsor_preferential/src/common/h5_url_format.dart';
import 'package:bw_sponsor_preferential/src/model/api_service.dart';
import 'package:bw_sponsor_preferential/src/model/support_details_entity.dart';
import 'package:bw_sponsor_preferential/src/widgets/support_footer_view.dart';
import 'package:bw_utils/bw_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SupportDetailsPage extends StatefulWidget {
  SupportDetailsPage({Key key, this.arguments}) : super(key: key);
  static final String KEY_ID = "key_id";

  final arguments;
  int id;

  // 解析路由数据
  void _initArguments() {
    if (arguments != null) {
      id = arguments[KEY_ID];
    }
  }

  @override
  _SupportDetailsPageState createState() {
    _initArguments();
    return _SupportDetailsPageState();
  }
}

class _SupportDetailsPageState extends State<SupportDetailsPage> {
  final primaryScrollController = ScrollController();

  SupportDetailsBean bean;

  //加载数据
  void _load() async {
    var entity = await ApiService.getSupDetailsInfo(widget.id);
    if (entity.code == 0) {
      if (entity.data != null) {
        bean = entity.data;
      }
      setState(() {});
    }
  }

  // 获取url
  String _formatUrl() {
    if (bean?.contextType == 1) {
      String head =
          ("<head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0," +
              "user-scalable=no\"><style>html{font-size:14px; word-break:break-all; word-wrap:break-word} img{max-width: 100%; width:auto;" +
              " height:auto;}</style><style>table{max-width: 100%; width:auto; height:auto;}</style>" +
              "</head>");
      return "<html>$head<body>${bean?.contextApp}</body></html>";
    } else {
      if (StringUtil.isNullOrEmpty(bean?.linkUrl)) {
        return "";
      }
      return H5UrlFormat.maybeAppendUrl(bean?.linkUrl);
    }
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(bean?.title ?? "详情"),
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: bean == null
          ? Container()
          : SingleChildScrollView(
              child: PrimaryScrollController(
                controller: primaryScrollController,
                child: Column(
                  children: <Widget>[
                    Text(_formatUrl()),
                    SupportFooterView(),
                  ],
                ),
              ),
            ),
    );
  }
}
