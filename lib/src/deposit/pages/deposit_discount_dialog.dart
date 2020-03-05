import 'package:flutter/material.dart';

class DepositDiscountDialog extends StatelessWidget {
  DepositDiscountDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 22,right: 30,top: 18,bottom: 18),
     child: Column(
       children: <Widget>[
         Text('存款优惠说明',style: TextStyle(fontSize: 18,color: Colors.black),),
Padding(
  padding: const EdgeInsets.only(top: 15),
  child:   Table(
    border: TableBorder.all(color: Colors.red, width: 1.0, style: BorderStyle.solid),



  ),
),

       ],
     ),

    );
  }
}
