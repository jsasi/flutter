import 'package:bw_res/res/res.dart';
import 'package:bw_res/res/strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SimpleImage {
  static CachedNetworkImage display(String imgUrl,
      {double width, double height}) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imgUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) =>
          Image.asset(R.default_holder, package: Strings.bwResPackage),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
