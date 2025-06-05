import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'loading.dart'; // لو انت عامل شيمر لودينج هنا

class ImageUrlControllerWidget extends StatelessWidget {
  const ImageUrlControllerWidget({
    super.key,
    required this.imageUrl,
    required this.borderRadius,
    this.width,
    this.height,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BorderRadiusGeometry borderRadius;

  bool get _isNetworkImage => imageUrl.startsWith('http') || imageUrl.startsWith('https');

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: _isNetworkImage
          ? CachedNetworkImage(
        fadeInDuration: Duration.zero,
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        height: height,
        width: width,
        placeholder: (context, url) => LoadingShimmer(
          borderRadius: borderRadius,
          height: height,
          width: width,
        ),
        errorWidget: (context, url, error) => LoadingShimmer(
          borderRadius: borderRadius,
          height: height,
          width: width,
        ),
      )
          : Image.asset(
        imageUrl,
        fit: BoxFit.fill,
        height: height,
        width: width,
      ),
    );
  }
}
