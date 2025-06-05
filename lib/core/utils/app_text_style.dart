import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

abstract class AppTextStyle {
  static TextStyle size24 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColor.black,
  );
  static TextStyle size23 = TextStyle(
    fontSize: 23.sp,
    fontWeight: FontWeight.w500, // medium

    color: AppColor.black,
  );
  static TextStyle size20White = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold, // medium

    color: AppColor.white,
  );
  static TextStyle size21 = TextStyle(
    fontSize: 21.sp,
    fontWeight: FontWeight.w500, // medium

    color: AppColor.black,
  );
  static TextStyle size20 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500, // medium
    color: AppColor.black,
  );
  static TextStyle size18 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500, // medium

    color: AppColor.black,
  );
  static TextStyle size16 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500, // medium

    color: AppColor.black,
  );
  static TextStyle size14 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500, // medium

    color: AppColor.black,
  );
  static TextStyle size12 = TextStyle(
    fontSize: 12.sp, // medium
    color: AppColor.black,
  );
  static TextStyle size11 = TextStyle(
    fontSize: 12.sp, // medium
    color: AppColor.greenLight,
  );

  //? get lang
}
