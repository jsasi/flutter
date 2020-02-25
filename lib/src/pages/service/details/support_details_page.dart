import 'package:flutter/material.dart';

class SupportDetailsPage extends StatefulWidget {
  SupportDetailsPage({Key key, this.arguments}) : super(key: key);
  static final String KEY_ID = "key_id";

  final arguments;
  String title;

  @override
  _SupportDetailsPageState createState() => _SupportDetailsPageState();
}

class _SupportDetailsPageState extends State<SupportDetailsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _buildBody());
    ;
  }

 Widget _buildBody() {





  }
}
