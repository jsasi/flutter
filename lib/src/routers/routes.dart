import 'package:flutter/material.dart';

import '../pages/discount/discount_page.dart';
import '../pages/discount_details/discount_details_page.dart';
import '../pages/sponsor/sponsor_page.dart';

class Routes {
  static String root = "/";
  static String discount = "/discount";
  static String discountDetails = "/discount-details";
  static String sponsor = "/sponsor";
}

final _routes = {
  Routes.root: (context) => SponsorPage(),
  Routes.discount: (context) => DiscountPage(),
  Routes.discountDetails: (context) => DiscountDetailsPage(),
  Routes.sponsor: (context) => SponsorPage(),
};

final Function onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuider = _routes[name];

  assert(pageContentBuider != null);

  return MaterialPageRoute(builder: (context) {
    if (settings.arguments != null) {
      return pageContentBuider(context, argments: settings.arguments);
    } else {
      return pageContentBuider(context);
    }
  });
};
