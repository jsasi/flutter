import 'package:bw_res/bw_res.dart';
import 'package:bw_sponsor_preferential/src/deposit/model/dep_dis_entity.dart';
import 'package:bw_utils/bw_utils.dart';
import 'package:flutter/material.dart';

class DepositDiscountDialog extends StatelessWidget {
  DepositDiscountDialog(this.data, {Key key}) : super(key: key);
  final List<DepDisBean> data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: EdgeInsets.only(left: 22, right: 30, top: 18, bottom: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '存款优惠说明',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 8),
              child: Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(60.0),
                  1: FixedColumnWidth(110.0),
                  2: FixedColumnWidth(110.0),
                },
                border: TableBorder.all(
                    color: BWColors.dssDivider,
                    width: 1.0,
                    style: BorderStyle.solid),
                children: <TableRow>[
                  TableRow(
                    children: <Widget>[
                      Container(
                        height: 35,
                        alignment: Alignment.center,
                        child: Text(
                          '会员等级',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                      Container(
                        height: 35,
                        alignment: Alignment.center,
                        child: Text(
                          '优惠百分比(%)',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                      Container(
                        height: 35,
                        alignment: Alignment.center,
                        child: Text(
                          '每日最高优惠(元)',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  ...getTableRow(),
                ],
              ),
            ),
            Text(
              '*具体到账金额以实际到账为准',
              style: TextStyle(fontSize: 12, color: BWColors.depDesRed),
            ),
            Container(
              height: 45,
              width: 184,
              margin: EdgeInsets.only(top: 21, bottom: 18),
              child: FlatButton(
                color: BWColors.dssBtnBg,
                onPressed: () => Navigator.pop(context),
                child: Text(
                  '关闭',
                  style: TextStyle(fontSize: 16, color: BWColors.dssBtnText),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getTableRow() {
    return data
        .map(
          (bean) => TableRow(
            children: <Widget>[
              Container(
                height: 35,
                alignment: Alignment.center,
                child: Text(
                  'VIP${bean.memberGrade}',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
              Container(
                height: 35,
                alignment: Alignment.center,
                child: Text(
                  '${getPercentValue(bean.depositRate)}',
                  style:
                      TextStyle(fontSize: 12, color: BWColors.depDialogValue),
                ),
              ),
              Container(
                height: 35,
                alignment: Alignment.center,
                child: Text(
                  '${getMaxDailyDiscount(bean.maxDailyDiscount)}',
                  style:
                      TextStyle(fontSize: 12, color: BWColors.depDialogValue),
                ),
              ),
            ],
          ),
        )
        .toList();
  }

  //优惠百分比
  String getPercentValue(String str) {
    String value = "- -";
    if (!StringUtil.isNullOrEmpty(str)) {
      if (str == "null") {
        value = "- -";
      } else {
        value = str + "%";
      }
    } else {
      value = "- -";
    }
    return value;
  }

  //每日最高优惠
  String getMaxDailyDiscount(String str) {
    String value = "- -";
    if (!StringUtil.isNullOrEmpty(str)) {
      if (str == "null") {
        value = "- -";
      } else {
        value = str;
      }
    } else {
      value = "- -";
    }
    return value;
  }
}
