import 'package:final_project_bfcai/core/utils/app_colors.dart';
import 'package:final_project_bfcai/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../widget/custom_card.dart';
import '../widget/design_image.dart';

class ProfileImageSetting extends StatelessWidget {
  static const String routeName = "profileImage";
  const ProfileImageSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.white,
      ),
      backgroundColor: AppColor.white,
      body:  SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.black.withOpacity(0.8),
                    builder: (context) {
                      return _AnimatedImageDialog();
                    },
                  );
                },
                child: DesignImage(
                  width: 200.w,
                  height: 200.w,
                  isCircle: true,
                ),
              ),
            ),
            Gap(10.h),
            Center(
              child: Text("Edit" ,style: AppTextStyle.size23.copyWith(
                  color: AppColor.primary,
                  fontWeight: FontWeight.bold
              ),),
            ),
            Gap(30.h),
            Text("Name",style: AppTextStyle.size18.copyWith(
              fontWeight: FontWeight.bold
            ),),
            Gap(3.h),
            CustomCard(
              name: "Mohamed Mousa",
            ),
            Gap(8.h),
            Text("Email",style: AppTextStyle.size18.copyWith(
                fontWeight: FontWeight.bold
            ),),
            Gap(3.h),
            CustomCard(
              name: "Mohamedmousa@gmail.com",
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedImageDialog extends StatefulWidget {
  const _AnimatedImageDialog({super.key});

  @override
  State<_AnimatedImageDialog> createState() => _AnimatedImageDialogState();
}

class _AnimatedImageDialogState extends State<_AnimatedImageDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.all(20),
      child: SlideTransition(
        position: _slideAnimation,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            padding: EdgeInsets.all(16.r),
            child: DesignImage(
              width: double.infinity,
              height: 250.h,
              isCircle: false,
            ),
          ),
        ),
      ),
    );
  }
}