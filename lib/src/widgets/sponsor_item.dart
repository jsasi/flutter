import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_sponsor_preferential/src/sponsor/model/sponsor_entity.dart';
import 'package:bw_sponsor_preferential/src/widgets/simple_imageview.dart';
import 'package:flutter/material.dart';

class SponsorItem extends StatelessWidget {
  final SponorItemBean data;

  SponsorItem(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 209,
            height: 148,
            child: SimpleImageView.display(
              data.sponsoredUrl,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: SimpleImageView.display(
                      data.sponsoredIconUrl,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7, bottom: 2),
                  child: Text(
                    data.firstCreative,
                    style: TextStyle(fontSize: 15, color: Colors.black),
                    maxLines: 1,
                  ),
                ),
                Text(
                  data.secondCreative,
                  style: TextStyle(fontSize: 12, color: BWColors.spoItemDesc),
                  maxLines: 1,
                ),
                Container(
                  height: 26,
                  width: 90,
                  margin: EdgeInsets.only(top: 12, left: 20, right: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: BWColors.dssBtnBg,
                      borderRadius: BorderRadius.circular(2)),
                  child: Text(
                    data.keyCreative,
                    style: TextStyle(
                      fontSize: 10,
                      color: BWColors.dssBtnText,
                    ),
                    maxLines: 1,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
