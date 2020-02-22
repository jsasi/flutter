import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_res/res/res.dart';
import 'package:flutter/material.dart';

import '../pages/model/discount_entity.dart';

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
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      elevation: 0.0,
      child: Stack(
        alignment: Alignment.topLeft, //指定未定位或部分定位widget的对齐方式
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 1),
            child: AspectRatio(
              aspectRatio: 5 / 2,
              child: Image.network(
                data.appListPicture,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              top: 8,
              child: Image.asset(
                _getTagName(data.activityTag),
              )),
          Positioned(
              bottom: 8,
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 7),
                      child: Image.asset(R.discount_item_clock),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 18),
                      child: Text(
                        '${data.activityStartTime} 至 ${data.activityEndTime}',
                        style: TextStyle(
                          fontSize: 10,
                          color: BWColors.disItemDesc,
                        ),
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
