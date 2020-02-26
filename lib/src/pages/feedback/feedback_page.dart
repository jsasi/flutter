import 'package:bw_res/bw_res.dart';
import 'package:bw_sponsor_preferential/src/widgets/dss_app_bar.dart';
import 'package:bw_sponsor_preferential/src/widgets/simple_imageview.dart';
import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  FeedbackPage({Key key}) : super(key: key);
  TextEditingController _unameController = new TextEditingController();
  List<String> images;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
        InkWell(
          onTap: () => _showQuestDialog(),
          child: Container(
            padding: EdgeInsets.only(left: 14, right: 14),
            height: 50,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  Strings.feeSelectTitle,
                  style: TextStyle(fontSize: 16, color: BWColors.dssDesc),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 14,
                  color: BWColors.dssDesc,
                )
              ],
            ),
          ),
        ),
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
              controller: _unameController,
              style: TextStyle(fontSize: 14, color: BWColors.feeInputText),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: BWColors.dssDivider),
                ),
                // 未获得焦点下划线设为灰色
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: BWColors.dssDivider),
                ),
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
          height: 50,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 14),
          color: Colors.white,
          child: ListView.builder(
              //解决 listview 嵌套报错
              physics: NeverScrollableScrollPhysics(),
              //禁用滑动事件
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildSelImageItem();
              }),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          padding: EdgeInsets.only(top: 20, left: 14, bottom: 10),
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
            child: FlatButton(
              onPressed: () => _submit(),
              color: BWColors.dssBtnBg,
              child: Text(
                Strings.submit,
                style: TextStyle(fontSize: 16, color: BWColors.dssBtnText),
              ),
            ),
          ),
        )
      ],
    );
  }

  /// 选择照片布局
  Widget _buildSelImageItem() {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: InkWell(
            onTap: () => _addImg(),
            child: SimpleImageView.assetImage(R.fee_select_img_add,
                width: 50, height: 50),
          ),
        ),
        Positioned(
          left: 42,
          bottom: 42,
          child: InkWell(
            onTap: () => _delImg(),
            child: Icon(
              Icons.ac_unit,
              size: 16,
            ),
          ),
        )
      ],
    );
  }

  _submit() {}

  _addImg() {}

  _delImg() {}

  _showQuestDialog() {
    _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
      final ThemeData themeData = Theme.of(context);
      return Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: themeData.disabledColor))),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            'This is a Material persistent bottom sheet. Drag downwards to dismiss it.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: themeData.accentColor,
              fontSize: 24.0,
            ),
          ),
        ),
      );
    });
  }
}
