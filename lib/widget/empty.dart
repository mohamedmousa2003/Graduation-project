import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../core/providers/animation_provider.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/app_text_style.dart';
import 'custom_dialog.dart';

class EmptyStateWidget extends StatefulWidget {
  final String? imagePath;
  final String title;
  final String? description;
  final String? buttonTitle;
  final VoidCallback? onPressed;
  final bool showButton;
  final double? imageWidth;
  final double? imageHeight;

  const EmptyStateWidget({
    super.key,
    this.imagePath,
    required this.title,
    this.description,
    this.buttonTitle,
    this.onPressed,
    this.showButton = false,
    this.imageWidth,
    this.imageHeight,
  });

  @override
  _EmptyStateWidgetState createState() => _EmptyStateWidgetState();
}

class _EmptyStateWidgetState extends State<EmptyStateWidget> with TickerProviderStateMixin {
  late AnimationManager _animationManager;

  @override
  void initState() {
    super.initState();
    _animationManager = AnimationManager();
    _animationManager.initialize(this,Duration(seconds: 1)); // تهيئة الـ AnimationManager
  }

  @override
  void dispose() {
    _animationManager.dispose(); // تحرير الموارد عند انتهاء الحياة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.imagePath != null)
              SlideTransition(
                position: _animationManager.sliderAnimationTop, // الأنيميشن من الشمال
                child: widget.imagePath!.endsWith('.svg')
                    ? SvgPicture.asset(
                  widget.imagePath!,
                  color: AppColor.lightGray,
                  width: widget.imageWidth,
                  height: widget.imageHeight,
                  fit: BoxFit.contain,
                )
                    : Image.asset(
                  widget.imagePath!,
                  color: AppColor.lightGray,
                  width: widget.imageWidth,
                  height: widget.imageHeight,
                  fit: BoxFit.contain,
                ),

              ),
            SizedBox(height: 12.h),
            SlideTransition(
              position: _animationManager.sliderAnimationLeft,
              child: Text(
                widget.title,
                style: AppTextStyle.size24,
                textAlign: TextAlign.center,
              ),
            ),
            if (widget.description != null)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: SlideTransition(
                  position: _animationManager.sliderAnimationBottom,
                  child: Text(
                    widget.description!,
                    style: AppTextStyle.size14.copyWith(color: AppColor.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            if (widget.showButton && widget.onPressed != null && widget.buttonTitle != null)
              Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: MaterialButtonWidget(
                  onPressed: widget.onPressed!,
                  title: Text(widget.buttonTitle!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
