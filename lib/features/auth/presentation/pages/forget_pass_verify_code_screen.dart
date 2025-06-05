import 'package:final_project_bfcai/core/extensions/context_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/constant/icons_assets.dart';
import '../../../../core/helper/observer.dart';
import '../../../../core/providers/animation_provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/const.dart';
import '../../../../widget/custom_dialog.dart';
import '../widget/resend_button_widget.dart';
import 'forget_pass_create_new_password_screen.dart';

class ForgetPassVerifyCode extends StatefulWidget {
  static const routeName = '/forgetPassVerifyCode';

  const ForgetPassVerifyCode({super.key});

  @override
  State<ForgetPassVerifyCode> createState() => _ForgetPassVerifyCodeState();
}

class _ForgetPassVerifyCodeState extends State<ForgetPassVerifyCode> with TickerProviderStateMixin, RouteAware {
  late AnimationManager _animationManager;

  @override
  void initState() {
    super.initState();
    _animationManager = AnimationManager();
    _animationManager.initialize(this, const Duration(milliseconds: 600));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // نربط الشاشة دي مع RouteObserver
    AppNavigatorObserver.instance.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    // نلغي الاشتراك
    AppNavigatorObserver.instance.unsubscribe(this);
    _animationManager.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    // يتم استدعاؤه لما ترجع للشاشة دي
    _animationManager.restartAnimation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColor.primary, size: 30),
        titleTextStyle: AppTextStyle.size21.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SlideTransition(
        position: _animationManager.sliderAnimationLeft,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(60.h),
              SlideTransition(
                position: _animationManager.sliderAnimationTop,
                child: SvgPicture.asset(
                  IconsSvg.lock,
                  width: 60.w,
                  height: 60.h,
                  color: AppColor.primary,
                ),
              ),
              Gap(8.h),
              SlideTransition(
                position: _animationManager.sliderAnimationLeft,
                child: Text(
                  enterVerificationCode,
                  style: AppTextStyle.size24,
                  textAlign: TextAlign.center,
                ),
              ),
              Gap(5.h),
              SlideTransition(
                position: _animationManager.sliderAnimationRight,
                child: Text(
                  desEnterVerificationCode,
                  style: AppTextStyle.size14.copyWith(color: AppColor.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Gap(5.h),
              SlideTransition(
                position: _animationManager.sliderAnimationLeft,
                child: Text(
                  "mohamedmousa11520031@gmail.com",
                  style: AppTextStyle.size16.copyWith(color: AppColor.primary),
                  textDirection: TextDirection.ltr,
                ),
              ),
              Gap(60.h),
              SlideTransition(
                position: _animationManager.sliderAnimationRight,
                child: Pinput(
                  length: 6,
                  keyboardType: TextInputType.number,
                  defaultPinTheme: PinTheme(
                    width: 50.w,
                    height: 50.h,
                    textStyle: AppTextStyle.size21,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColor.primary, width: 2),
                    ),
                  ),
                  errorPinTheme: PinTheme(
                    width: 50.w,
                    height: 50.h,
                    textStyle: AppTextStyle.size21,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColor.red),
                    ),
                  ),
                  controller: TextEditingController(),
                  focusedPinTheme: PinTheme(
                    width: 50.w,
                    height: 50.h,
                    textStyle: AppTextStyle.size21,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColor.primary, width: 2),
                    ),
                  ),
                  followingPinTheme: PinTheme(
                    width: 50.w,
                    height: 50.h,
                    textStyle: AppTextStyle.size21,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColor.black),
                    ),
                  ),
                ),
              ),
              Gap(24.h),
              ResendButtonWidget(resendFunction: () {}),
              Gap(24.h),
              SlideTransition(
                position: _animationManager.sliderAnimationBottom,
                child: MaterialButtonWidget(
                  onPressed: () {
                    context.pushNamed(ForgetPassCreateNewPasswordScreen.routeName);
                  },
                  title: Text(verification),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
