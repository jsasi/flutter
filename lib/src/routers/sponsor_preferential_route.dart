import 'package:bw_base/bw_base.dart';
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
import 'package:bw_sponsor_preferential/src/sponsor/pages/web/web_page.dart';
import 'package:bw_sponsor_preferential/src/widgets/photo_gallery_page.dart';
import 'package:flutter/material.dart';

class SponsorPreferentialRoute implements BwPackageRoute {
  static const String discount = "/bw_sp_discount";
  static const String discountDetails = "/bw_sp_discount-details";
  static const String sponsorDetails = "/bw_sp_sponsor-details";
  static const String supportCenter = "/bw_sp_support_center";
  static const String supportDetails = "/bw_sp_support-details";
  static const String sponsor = "/bw_sp_sponsor";
  static const String service = "/bw_sp_service";
  static const String feedback = "/bw_sp_feedback";
  static const String feedbackDetails = "/bw_sp_feedback-details";
  static const String feedbackList = "/bw_sp_feedback-list";
  static const String webPage = "/bw_sp_webpage";
  static const String customerService = "/bw_sp_customer-service";
  static const String photoGallery = "/bw_sp_photo_allery";
  static const String helpCenter = "/bw_sp_help_center";
  static const String depositOrder = "/bw_sp_deposit-order";
  static const String deposit = "/bw_sp_deposit";

  SponsorPreferentialRoute._();

  static final SponsorPreferentialRoute _bwSpRoutes = SponsorPreferentialRoute._();

  factory SponsorPreferentialRoute() => _bwSpRoutes;

  @override
  Map<String, WidgetBuilder> packageRoutes() {
    return {
      /// 优惠列表
      SponsorPreferentialRoute.discount: (context) => DiscountPage(),

      /// 赞助
      SponsorPreferentialRoute.sponsor: (context) => SponsorPage(),

      /// 客服首页
      SponsorPreferentialRoute.service: (context) => ServicePage(),

      /// 意见反馈
      SponsorPreferentialRoute.feedback: (context) => FeedbackPage(),

      /// 意见反馈列表
      SponsorPreferentialRoute.feedbackList: (context) => FeedbackListPage(),

      /// 帮助中心
      SponsorPreferentialRoute.helpCenter: (context) => HelpCenterPage(),

      /// 存款
      SponsorPreferentialRoute.deposit: (context) => DepositPage(),
    };
  }

  @override
  Route<dynamic> generatePackageRoute(RouteSettings settings) {
    switch (settings.name) {
      case SponsorPreferentialRoute.supportCenter: // 客服中心
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return SupportCenterListPage(bean: settings.arguments);
          },
        );
      case SponsorPreferentialRoute.supportDetails: // 客服帮助详情
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return SupportDetailsPage(id: settings.arguments);
          },
        );
      case SponsorPreferentialRoute.customerService: // 客服页面
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return CustomerServicePage(url: settings.arguments);
          },
        );
      case SponsorPreferentialRoute.feedbackDetails: // 意见反馈详情
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return FeedbackDetailsPage(id: settings.arguments);
          },
        );
      case SponsorPreferentialRoute.depositOrder: // 订单详情
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return DepositOrderPage(data: settings.arguments);
          },
        );
      case SponsorPreferentialRoute.discountDetails: // 优惠详情
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return DiscountDetailsPage(data: settings.arguments);
          },
        );
      case SponsorPreferentialRoute.photoGallery: // 画廊
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            Map<String, dynamic> map = settings.arguments;
            return PhotoViewGalleryScreen(
              files: map[PhotoViewGalleryScreen.KEY_FILES],
              imgUrls: map[PhotoViewGalleryScreen.KEY_IMG_URLS],
              index: map[PhotoViewGalleryScreen.KEY_INDEX],
            );
          },
        );
      case SponsorPreferentialRoute.webPage: // web
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            Map<String, dynamic> map = settings.arguments;
            return WebPage(
              title: map[WebPage.KEY_URL],
              url: map[WebPage.KEY_URL],
            );
          },
        );
      case SponsorPreferentialRoute.sponsorDetails: // 赞助详情
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            Map<String, dynamic> map = settings.arguments;
            return SponsorDetailsPage(
              title: map[SponsorDetailsPage.KEY_TITLE],
              url: SponsorDetailsPage.KEY_URL,
            );
          },
        );
      default:
        return null;
    }
  }
}

SponsorPreferentialRoute bwSpRoute = SponsorPreferentialRoute();
