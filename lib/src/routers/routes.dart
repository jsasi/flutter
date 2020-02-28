import 'package:bw_sponsor_preferential/src/pages/debug_page.dart';
import 'package:bw_sponsor_preferential/src/pages/feedback/feeback_list_page.dart';
import 'package:bw_sponsor_preferential/src/pages/feedback/feedback_details_page.dart';
import 'package:bw_sponsor_preferential/src/pages/feedback/feedback_page.dart';
import 'package:bw_sponsor_preferential/src/pages/service/details/support_details_page.dart';
import 'package:bw_sponsor_preferential/src/pages/service/home/customer_service_page.dart';
import 'package:bw_sponsor_preferential/src/pages/service/home/service_page.dart';
import 'package:bw_sponsor_preferential/src/pages/service/support/support_center_page.dart';
import 'package:bw_sponsor_preferential/src/pages/sponsor/sponsor_details_page.dart';
import 'package:bw_sponsor_preferential/src/pages/web/web_page.dart';
import 'package:bw_sponsor_preferential/src/widgets/photo_gallery_page.dart';
import 'package:flutter/material.dart';
import '../pages/discount/discount_page.dart';
import '../pages/discount_details/discount_details_page.dart';
import '../pages/sponsor/sponsor_page.dart';

class Routes {
  static String root = "/";
  static String discount = "/discount";
  static String discountDetails = "/discount-details";
  static String sponsorDetails = "/sponsor-details";
  static String supportCenter = "/support-center";
  static String supportDetails = "/support-details";
  static String sponsor = "/sponsor";
  static String service = "/service";
  static String feedback = "/feedback";
  static String feedbackDetails = "/feedback-details";
  static String feedbackList = "/feedback-list";
  static String webPage = "/webpage";
  static String customerService = "/customer-service";
  static String photoGallery = "/photo_allery";
}

final _routes = {
  Routes.root: (context) => DebugPage(),

  /// 优惠列表
  Routes.discount: (context) => DiscountPage(),

  /// 优惠详情
  Routes.discountDetails: (context, {arguments}) =>
      DiscountDetailsPage(arguments: arguments),

  /// 赞助详情
  Routes.sponsorDetails: (context, {arguments}) =>
      SponsorDetailsPage(arguments: arguments),

  /// 赞助
  Routes.sponsor: (context) => SponsorPage(),

  /// 客服首页
  Routes.service: (context) => SevicePage(),

  /// 客服中心
  Routes.supportCenter: (context, {arguments}) =>
      SupportCenterListPage(arguments: arguments),

  /// 客服帮助详情
  Routes.supportDetails: (context, {arguments}) =>
      SupportDetailsPage(arguments: arguments),

  /// 客服页面
  Routes.customerService: (context, {arguments}) =>
      CustomerServicePage(arguments: arguments),

  /// web
  Routes.webPage: (context, {arguments}) =>
      CustomerServicePage(arguments: arguments),

  /// 意见反馈
  Routes.feedback: (context, {arguments}) => FeedbackPage(),

  /// 意见反馈详情
  Routes.feedbackDetails: (context, {arguments}) => FeedbackDetailsPage(),

  /// 意见反馈列表
  Routes.feedbackList: (context, {arguments}) => FeedbackListPage(),

  /// 画廊
  Routes.photoGallery: (context, {arguments}) =>
      PhotoViewGalleryScreen(arguments: arguments),
};

final Function onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  debugPrint('name==============================$name');
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
