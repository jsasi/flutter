import 'package:biz_login/biz_login.dart';

class H5UrlFormat {

  static String h5Domain = "http://h5.kok1065.com";

  static String getH5Url(String url) {
    String token = LoginUtil.token;
    return "$h5Domain$url?token=${token ?? ''}";
  }
}
