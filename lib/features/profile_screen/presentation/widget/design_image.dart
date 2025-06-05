import 'package:flutter/material.dart';
import '../../../../core/constant/images_assets.dart';

class DesignImage extends StatelessWidget {
  final double width;
  final double height;
  final bool isCircle;

  const DesignImage({
    super.key,
    required this.width,
    required this.height,
    this.isCircle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(12), // زاوية بسيطة لو مش دائرية
        image: const DecorationImage(
          image: AssetImage(ImagePng.profileScreen),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
