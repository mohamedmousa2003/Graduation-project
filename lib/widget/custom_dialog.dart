import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../core/utils/const.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final double heightICon;
  final double widthICon;
  final String iconPath;

  final String? confirmText;
  final String? cancelText;
  final Color confirmTextColor;
  final Color cancelTextColor;
  final Color confirmBackgroundColor;
  final Color cancelBackgroundColor;
  final bool cancelHaveBorder;
  final double buttonRadius;

  const CustomDialog({
    super.key,
    required this.title,
    required this.widthICon,
    required this.heightICon,
    required this.content,
    required this.onConfirm,
    required this.iconPath,
    required this.onCancel,
    this.confirmText,
    this.cancelText,
    this.confirmTextColor = Colors.white,
    this.cancelTextColor = AppColor.primary,
    this.confirmBackgroundColor = AppColor.primary,
    this.cancelBackgroundColor = Colors.transparent,
    this.cancelHaveBorder = true,
    this.buttonRadius = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      title: Column(
        children: [
          _buildCircularImage(iconPath),
          Gap(14.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.size18.copyWith(
              color: const Color(0xFF121212),
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(2.h),
        ],
      ),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: AppTextStyle.size14.copyWith(color: AppColor.grayWhite),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: MaterialButtonWidget(
                title: Text(cancelText ?? cancel),
                colorText: cancelTextColor,
                onPressed: onCancel,
                radius: buttonRadius.r,
                colorBackground: cancelBackgroundColor,
                haveBorder: cancelHaveBorder,
              ),
            ),
            Gap(12.w),
            Expanded(
              child: MaterialButtonWidget(
                title: Text(confirmText ?? done),
                onPressed: onConfirm,
                radius: buttonRadius.r,
                colorBackground: confirmBackgroundColor,
                colorText: confirmTextColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCircularImage(String path) {
    return ClipOval(
      child: Container(
        width: widthICon.w,
        height: heightICon.h,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child:
            path.toLowerCase().endsWith('.svg')
                ? SvgPicture.asset(
                  path,
                  fit: BoxFit.cover,
                  width: widthICon.w,
                  height: heightICon.h,
                )
                : Image.asset(
                  path,
                  fit: BoxFit.fill,
                  width: widthICon.w,
                  height: heightICon.h,
                ),
      ),
    );
  }
}

class MaterialButtonWidget extends StatelessWidget {
  MaterialButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.colorText,
    this.colorBackground,
    this.fontWeight,
    this.haveBorder = false,
    this.radius,
  });

  final Widget title; // تغيير هنا من String إلى Widget
  final void Function()? onPressed;
  final Color? colorText;
  final Color? colorBackground;
  final FontWeight? fontWeight;
  final double? radius;
  bool haveBorder = false;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      minWidth: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 50.r),
        side: BorderSide(
          color: haveBorder ? AppColor.primary : Colors.transparent,
          width: 2,
        ),
      ),
      onPressed: onPressed,
      color: colorBackground ?? AppColor.primary,
      child: DefaultTextStyle(
        style: AppTextStyle.size18.copyWith(
          color: colorText ?? AppColor.white,
          fontWeight: fontWeight ?? FontWeight.bold,
        ),
        child: title,
      ),
    );
  }
}
