import 'package:bw_sponsor_preferential/src/pages/service/home/service_page.dart';
import 'package:bw_sponsor_preferential/src/pages/sponsor/sponsor_details_page.dart';
import 'package:flutter/material.dart';

import '../pages/discount/discount_page.dart';
import '../pages/discount_details/discount_details_page.dart';
import '../pages/sponsor/sponsor_page.dart';

class Routes {
  static String root = "/";
  static String discount = "/discount";
  static String discountDetails = "/discount-details";
  static String sponsorDetails = "/sponsor-details";
  static String sponsor = "/sponsor";
  static String service = "/service";
}

final _routes = {
  Routes.root: (context) => SponsorPage(),
  Routes.discount: (context) => DiscountPage(),
  Routes.discountDetails: (context, {arguments}) =>
      DiscountDetailsPage(arguments: arguments),
  Routes.sponsorDetails: (context, {arguments}) =>
      SponsorDetailsPage(arguments: arguments),
  Routes.sponsor: (context) => SponsorPage(),
  Routes.service: (context) => SponsorPage(),
};

final Function onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuider = _routes[name];

  assert(pageContentBuider != null);

  return MaterialPageRoute(builder: (context) {
    if (settings.arguments != null) {
      return pageContentBuider(context, arguments: settings.arguments);
    } else {
      return pageContentBuider(context);
    }
  });
};
