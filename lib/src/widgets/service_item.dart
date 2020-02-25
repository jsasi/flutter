import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_res/res/res.dart';
import 'package:bw_res/res/strings.dart';
import 'package:bw_sponsor_preferential/src/widgets/simple_imageview.dart';
import 'package:bw_sponsor_preferential/src/model/discount_entity.dart';
import 'package:bw_sponsor_preferential/src/model/service_entity.dart';
import 'package:flutter/material.dart';

class ServiceItem extends StatelessWidget {
  final ServiceItemBean data;

  ServiceItem(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 70,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 10),
            child: SimpleImageView.displayIcon(data.iconUrl, width: 32, height: 32),
          ),
          Text(
            data.name,
            style: TextStyle(fontSize: 14, color: BWColors.feeTitle),
          ),
          Expanded(
            child: data.shortTitle != null
                ? Text(
                    data.shortTitle,
                    maxLines: 1,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(fontSize: 12, color: BWColors.feeItemDesc),
                  )
                : Container(),
          ),
          Padding(
            padding: const EdgeInsets.only(left:15,right: 20),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 13,
              color: BWColors.dssItemArrow,
            ),
          )
        ],
      ),
    );
  }
}
