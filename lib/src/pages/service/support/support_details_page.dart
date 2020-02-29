import 'package:bw_res/res/res.dart';
import 'package:bw_sponsor_preferential/bw_sponsor_preferential.dart';
import 'package:bw_sponsor_preferential/src/common/h5_url_format.dart';
import 'package:bw_sponsor_preferential/src/model/api_service.dart';
import 'package:bw_sponsor_preferential/src/model/support_details_entity.dart';
import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:bw_sponsor_preferential/src/widgets/support_footer_view.dart';
import 'package:bw_utils/bw_utils.dart';
import 'package:flutter/material.dart';

/// 帮助中心详情
class SupportDetailsPage extends StatefulWidget {
  SupportDetailsPage({Key key, this.arguments}) : super(key: key);
  static const String KEY_ID = "key_id";

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

  // 获取html
  String _appendHtml() {
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
        appBar: DssAppBar(
          bean?.title ?? "详情",
          hideLeftArrow: false,
          rightImg: R.service_icon,
          callBack: () => Navigator.pushNamed(context, Routes.customerService),
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
                    Text(_appendHtml()),
                    SupportFooterView(),
                  ],
                ),
              ),
            ),
    );
  }
}
