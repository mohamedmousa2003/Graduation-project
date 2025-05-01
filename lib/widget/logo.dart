import 'package:final_project_bfcai/core/constant/images_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/app_colors.dart';

class Logo extends StatelessWidget {
  final double width;
  final double height;
  final double imageSize;
  final Color colorBorder;
  const Logo({
    super.key,
    this.width = 55,
    this.height = 55,
    this.imageSize = 40,
    this.colorBorder=AppColor.lightGray,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        color: AppColor.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: colorBorder,
          width: 2,
        ),
      ),
      child: Center(
        child: Image.asset(
          ImagePng.logo,
          width: imageSize.w,
          height: imageSize.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
