import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constant/icons_assets.dart';
import '../../../../core/constant/images_assets.dart';
import '../../../../core/utils/app_colors.dart';

class CustomImage extends StatelessWidget {
  final VoidCallback onTap;

  const CustomImage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 40.r,
          backgroundColor: const Color(0xFFEEEEEE),
          child: Image.asset(
            ImagePng.user,
            width: 50.w,
            height: 50.h,
            fit: BoxFit.cover,
          ),
        ),

        Positioned(
          bottom: -4.h,
          right: -4.w,
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: onTap,
              child: Container(
                width: 28.w,
                height: 28.h,
                decoration: const BoxDecoration(
                  color: AppColor.primary,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(6.r),
                child: SvgPicture.asset(
                  IconsSvg.cameraProfile,
                  color: AppColor.white,
                  width: 16.w,
                  height: 16.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
