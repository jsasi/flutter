import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_sponsor_preferential/src/common/display_image.dart';
import 'package:bw_sponsor_preferential/src/model/sponsor_entity.dart';
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
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SimpleImage.display(
            data.sponsoredUrl,
            width: 209,
            height: 148,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child:  SimpleImage.display(
                    data.sponsoredIconUrl,
                    width: 32,
                    height: 32,
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
                  width: 90,
                  height: 26,
                  margin: EdgeInsets.only(top: 12),
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    textColor: Colors.white,
                    color: BWColors.spoBtnBg,
                    child: Text(
                      data.keyCreative,
                      style: TextStyle(fontSize: 10),
                      maxLines: 1,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2)),
                    onPressed: () {},
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
