import 'package:bw_base/bw_base.dart';
import 'package:bw_res/bw_res.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/feedback_entity.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/feedback/feedback_res_utils.dart';
import 'package:bw_sponsor_preferential/src/widgets/simple_imageview.dart';
import 'package:bw_utils/bw_utils.dart';
import 'package:flutter/material.dart';

class FeedbackItem extends StatelessWidget {
  final FeedbackItemBean data;

  FeedbackItem(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.only(left: 14, right: 14),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          SimpleImageView.assetImage(
              FeedbackResUtils.getResIdByCode(data.category.toString()),
              width: 32,
              height: 32),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          data.description,
                          style: TextStyle(
                              fontSize: 14, color: BWColors.dssTitleLeftArrow),
                        ),
                      ),
                    ),
                    Text(
                      data.createdAt,
                      style: TextStyle(fontSize: 10, color: BWColors.dssDesc),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 24),
                          child: Text(
                            data.content,
                            style: TextStyle(
                                fontSize: 12, color: BWColors.dssDesc),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      if (data.status == 0 &&
                          appSharedPreferences.getBool(data.id.toString()) ==
                              null)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: BWColors.feeRedDot),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
