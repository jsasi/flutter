import 'package:bw_res/res/res.dart';
import 'package:bw_res/res/strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SimpleImageView {
  /// return 带有默认占位图和错误图片的CachedNetworkImage
  /// 通用于网络图片
  static CachedNetworkImage display(String imgUrl,
      {double width, double height}) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imgUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Image.asset(
        R.default_holder,
        package: Strings.bwResPackage,
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
      errorWidget: (context, url, error) => Image.asset(
        R.default_holder,
        package: Strings.bwResPackage,
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
    );
  }

  /// return 带有默认占位图和错误图片的CachedNetworkImage
  /// 通用于icon类型的图标
  static CachedNetworkImage displayIcon(String imgUrl,
      {double width, double height, errorAsset = R.default_icon_holder}) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imgUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Image.asset(
        errorAsset,
        package: Strings.bwResPackage,
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
      errorWidget: (context, url, error) => Image.asset(
        errorAsset,
        package: Strings.bwResPackage,
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
    );
  }

  /// package：bw
  /// 本地图片image
  static Image assetImage(String name,
      {double width, double height, package = Strings.bwResPackage}) {
    return Image.asset(
      name,
      package: package,
      width: width,
      height: height,
    );
  }
}
