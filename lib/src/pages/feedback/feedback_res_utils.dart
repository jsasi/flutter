import 'package:bw_res/res/res.dart';

class FeedbackResUtils {
  /// 根据code返回图标资源
  static String getResIdByCode(String code) {
    switch (code) {
      case "1":
        return R.feed_ic_deposit;
        break;
      case "2":
        return R.feed_ic_withdrawal;
        break;
      case "3":
        return R.feed_ic_game;
        break;
      case "4":
        return R.feed_ic_discount;
        break;
      case "5":
        return R.feed_ic_login;
        break;
      case "6":
        return R.feed_ic_modify_info;
        break;
      case "7":
        return R.feed_ic_flow_water;
        break;
      case "8":
      default:
        return R.feed_ic_other;
    }
  }
}
