import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restobuy_supplier_flutter/common/constants/strings.dart';

Widget cachedNetImgWithRadius(String url, double width, double height, double radius, BoxFit boxFit) => ClipRRect(
  borderRadius: BorderRadius.circular(radius),
  child: CachedNetworkImage(
    height: height,
    width: width,
    fit: boxFit,
    //placeholder: (context, url) => CircularProgressIndicator(),
    imageUrl: url,
    progressIndicatorBuilder: (context, url, downloadProgress) =>
        Center(child: Lottie.asset('assets/animations/lottiefiles/3_line_loading.json', fit: BoxFit.cover, width: 300, height: 250),),
    errorWidget: (context, url, error) => Image.network(Strings.imgUrlNotFound),
  ),
);
