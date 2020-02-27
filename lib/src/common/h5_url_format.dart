import 'package:biz_login/biz_login.dart';
import 'package:bw_base/bw_base.dart';

class H5UrlFormat {
  /// 根据path拼接host和token
  static String appendUrl(String url) {
    String token = LoginUtil.token;
    String h5Domain =
        PreInfoUtil.getPreInfoEntity()?.siteBaseConfig?.h5DomainUrl;
    return "$h5Domain$url?token=${token ?? ''}";
  }

  /// 判断是否有http协议，没有就拼接
  static String maybeAppendUrl(String url) {
    if (url.startsWith("http")) {
      return url;
    } else {
      String token = LoginUtil.token;
      String h5Domain =
          PreInfoUtil.getPreInfoEntity()?.siteBaseConfig?.h5DomainUrl;
      return "$h5Domain$url?token=${token ?? ''}";
    }
  }
}
