import 'package:bw_sponsor_preferential/bw_sponsor_preferential.dart';
import 'package:bw_sponsor_preferential/src/pages/service/home/customer_service_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SupportFooterView extends StatelessWidget {
  final TapGestureRecognizer _recognizer = new TapGestureRecognizer();

  SupportFooterView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _recognizer.onTap = () => Navigator.of(context).pushNamed(
        Routes.customerService,
        // todo
        arguments: {CustomerServicePage.KEY_URL: "https://chat.8ztq7o.com/chat/chatClient/chatbox.jsp?companyID=5889090&configID=2"});

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 24, bottom: 10),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "没有找到解决办法？联系",
              style: TextStyle(
                  fontSize: 12, color: Color.fromARGB(255, 102, 102, 102)),
            ),
            TextSpan(
              text: "人工客服",
              recognizer: _recognizer,
              style: TextStyle(
                  fontSize: 12, color: Color.fromARGB(255, 21, 139, 244)),
            ),
            TextSpan(
              text: "解决",
              style: TextStyle(
                  fontSize: 12, color: Color.fromARGB(255, 102, 102, 102)),
            ),
          ],
        ),
      ),
    );
  }
}
