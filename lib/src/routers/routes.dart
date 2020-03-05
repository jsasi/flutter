import 'package:bw_sponsor_preferential/src/deposit/pages/deposit_order_page.dart';
import 'package:bw_sponsor_preferential/src/deposit/pages/deposit_page.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/discount/discount_page.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/discount_details/discount_details_page.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/feedback/feeback_list_page.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/feedback/feedback_details_page.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/feedback/feedback_page.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/service/home/customer_service_page.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/service/home/service_page.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/service/support/help_center_page.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/service/support/support_center_page.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/service/support/support_details_page.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/sponsor/sponsor_details_page.dart';
import 'package:bw_sponsor_preferential/src/sponsor/pages/sponsor/sponsor_page.dart';
import 'package:bw_sponsor_preferential/src/widgets/photo_gallery_page.dart';
import 'package:flutter/material.dart';

class BwSpRoutes {
  static String discount = "/bw_sp_discount";
  static String discountDetails = "/bw_sp_discount-details";
  static String sponsorDetails = "/bw_sp_sponsor-details";
  static String supportCenter = "/bw_sp_support_center";
  static String supportDetails = "/bw_sp_support-details";
  static String sponsor = "/bw_sp_sponsor";
  static String service = "/bw_sp_service";
  static String feedback = "/bw_sp_feedback";
  static String feedbackDetails = "/bw_sp_feedback-details";
  static String feedbackList = "/bw_sp_feedback-list";
  static String webPage = "/bw_sp_webpage";
  static String customerService = "/bw_sp_customer-service";
  static String photoGallery = "/bw_sp_photo_allery";
  static String helpCenter = "/bw_sp_help_center";
  static String depositOrder = "/bw_sp_deposit-order";
  static String deposit = "/bw_sp_deposit";

  static final Function onGenerateRoute = (RouteSettings settings) {
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

}

final _routes = {
  /// 优惠列表
  BwSpRoutes.discount: (context) => DiscountPage(),

  /// 优惠详情
  BwSpRoutes.discountDetails: (context, {arguments}) =>
      DiscountDetailsPage(arguments: arguments),

  /// 赞助详情
  BwSpRoutes.sponsorDetails: (context, {arguments}) =>
      SponsorDetailsPage(arguments: arguments),

  /// 赞助
  BwSpRoutes.sponsor: (context) => SponsorPage(),

  /// 客服首页
  BwSpRoutes.service: (context) => ServicePage(),

  /// 客服中心
  BwSpRoutes.supportCenter: (context, {arguments}) =>
      SupportCenterListPage(arguments: arguments),

  /// 客服帮助详情
  BwSpRoutes.supportDetails: (context, {arguments}) =>
      SupportDetailsPage(arguments: arguments),

  /// 客服页面
  BwSpRoutes.customerService: (context, {arguments}) =>
      CustomerServicePage(arguments: arguments),

  /// web
  BwSpRoutes.webPage: (context, {arguments}) =>
      CustomerServicePage(arguments: arguments),

  /// 意见反馈
  BwSpRoutes.feedback: (context, {arguments}) => FeedbackPage(),

  /// 意见反馈详情
  BwSpRoutes.feedbackDetails: (context, {arguments}) =>
      FeedbackDetailsPage(arguments: arguments),

  /// 意见反馈列表
  BwSpRoutes.feedbackList: (context, {arguments}) => FeedbackListPage(),

  /// 画廊
  BwSpRoutes.photoGallery: (context, {arguments}) =>
      PhotoViewGalleryScreen(arguments: arguments),

  /// 帮助中心
  BwSpRoutes.helpCenter: (context, {arguments}) => HelpCenterPage(),

  /// 存款
  BwSpRoutes.deposit: (context, {arguments}) => DepositPage(),

  /// 订单详情
  BwSpRoutes.depositOrder: (context, {arguments}) =>DepositOrderPage(arguments: arguments),
};


