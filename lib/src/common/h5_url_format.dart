import 'package:biz_app_init/biz_app_init.dart';
import 'package:biz_login/biz_login.dart';

class H5UrlFormat {

  /// 根据path拼接host和token
  static String getH5Url(String url) {
    String token = LoginUtil.token;
    String h5Domain = AppInit().h5Host;
    return "$h5Domain$url?token=${token ?? ''}";
  }
}
