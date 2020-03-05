import 'package:bw_base/bw_base.dart';
import 'package:bw_sponsor_preferential/bw_sponsor_preferential.dart';
import 'package:flutter/material.dart';

class CustomerRouteUtils {
  static goCustomerPage(BuildContext context, {int index = 0}) {
    Navigator.of(context).pushNamed(BwSpRoutes.customerService,
        arguments: PreInfoUtil.getPreInfoEntity()
            .siteBaseConfig
            .getCustomerServices()[index]
            .url);
  }
}
