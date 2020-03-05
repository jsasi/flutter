import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_res/res/res.dart';
import 'package:bw_sponsor_preferential/src/deposit/model/dep_dis_entity.dart';
import 'package:bw_sponsor_preferential/src/deposit/pages/deposit_discount_dialog.dart';
import 'package:bw_sponsor_preferential/src/widgets/simple_imageview.dart';
import 'package:bw_utils/bw_utils.dart';
import 'package:flutter/material.dart';

/// 存款优惠提示
class DepositDisTipsView extends StatelessWidget {
  DepositDisTipsView( this.depositRate, this.maxDailyDiscount,this.showDisDialog,{Key key,})
      : super(key: key);
  final String depositRate;
  final String maxDailyDiscount;
  final Function showDisDialog;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BWColors.allGgColor,
      padding: EdgeInsets.only(left: 14, right: 16, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (!StringUtil.isNullOrEmpty(depositRate))
                Text(
                  '存款成功额外加送：$depositRate',
                  style: TextStyle(fontSize: 14, color: Colors.red),
                ),
              Expanded(
                child: InkWell(
                  onTap: showDisDialog,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    children: <Widget>[
                      if (!StringUtil.isNullOrEmpty(maxDailyDiscount))
                        Text('每日最高优惠：$maxDailyDiscount元',
                            style: TextStyle(fontSize: 14, color: Colors.red)),
                      SimpleImageView.assetImage(R.deposit_dis_help_center,
                          width: 10, height: 10)
                    ],
                  ),
                ),
              )
            ],
          ),
          Text(
            '具体到账金额以实际到账为准',
            style: TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 170, 170, 170)),
          ),
        ],
      ),
    );
  }


}
