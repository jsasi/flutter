import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_res/res/res.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_sponsor_preferential/src/model/discount_entity.dart';
import 'package:bw_sponsor_preferential/src/model/feedback_entity.dart';
import 'package:bw_sponsor_preferential/src/widgets/simple_imageview.dart';
import 'package:flutter/material.dart';

class FeedbackItem extends StatelessWidget {
  final FeedbackItemBean data;

  String _getTagName(String tag) {
    switch (tag) {
      case "1":
        return R.discount_label_zuixin;
      case "2":
        return R.discount_label_richang;
      case "3":
        return R.discount_label_xinren;
      case "4":
        return R.discount_label_vip;
      default:
        return R.discount_label_richang;
    }
  }

  FeedbackItem(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.white,
      child: Text('data'),
    );
  }
}
