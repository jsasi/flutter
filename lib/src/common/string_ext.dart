extension StringExt on String {

  // "2020-02-29 23:59:59"类型的字符串截取为"2020-02-29 "
  String subDate() {
    if (this.length > 10) {
      return this.substring(0, 10);
    } else {
      return this;
    }
  }


}

