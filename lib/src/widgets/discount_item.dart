import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_res/res/res.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_sponsor_preferential/src/model/discount_entity.dart';
import 'package:flutter/material.dart';

class DiscountItem extends StatelessWidget {
  final DiscountItemBean data;

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

  DiscountItem(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(left: 12, top: 10, right: 12, bottom: 6),
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      elevation: 0.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 5 / 2,
            child: Image.network(
              data.appListPicture,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 8),
                      child: Text(
                        data.title,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 12, color: BWColors.disItemTitle),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 4, bottom: 8),
                      child: Text(
                        '${data.activityStartTime}-${data.activityEndTime}',
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 10, color: BWColors.disItemDesc),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                _getTagName(data.activityTag),
                package: Strings.bwResPackage,
                width: 35.5,
                height: 35.5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
