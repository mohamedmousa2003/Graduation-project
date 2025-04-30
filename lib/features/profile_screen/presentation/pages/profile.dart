import 'package:final_project_bfcai/core/utils/app_colors.dart';
import 'package:final_project_bfcai/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/const.dart';
import '../../../../widget/text_form.dart';
import '../widget/design_image.dart';

class ProfileImageScreen extends StatelessWidget {
  static const String routeName = "profileImage";
  const ProfileImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.backgroundColor,
      ),
      backgroundColor: AppColor.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
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
          Gap(10.h),
          Text("Edit" ,style: AppTextStyle.size23.copyWith(
            color: AppColor.primary,
            fontWeight: FontWeight.bold
          ),),
          Gap(30.h),
          TextFormFieldWidget(
            hintText: "Mohamed Mousa",
            title: "name",
            controller: TextEditingController(),
            myValidator: (text) => null,
          ),
        ],
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
