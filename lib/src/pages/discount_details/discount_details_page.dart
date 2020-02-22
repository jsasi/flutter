import 'package:bw_res/res/bw_colors.dart';
import 'package:bw_res/res/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscountDetailsPage extends StatelessWidget {
  const DiscountDetailsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: BWColors.disTitle,
            ),
            onPressed: () => Navigator.of(context).pop()),
        title: Text(
          Strings.disDetailsTitle,
          style: TextStyle(fontSize: 18, color: BWColors.disTitle),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_downward),
          ),
        ],
      ),
      body: SafeArea(
        child: Text('text'),
      ),
    );
  }
}
