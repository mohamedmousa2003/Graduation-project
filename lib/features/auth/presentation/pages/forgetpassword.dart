import 'package:final_project_bfcai/core/extensions/context_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../../core/constant/icons_assets.dart';
import '../../../../core/helper/observer.dart';
import '../../../../core/providers/animation_provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/const.dart';
import '../../../../widget/custom_dialog.dart';
import '../../../../widget/text_form.dart';
import 'forget_pass_verify_code_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routeName = 'ForgetPasswordScreen';

  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> with TickerProviderStateMixin, RouteAware {
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        physics: const BouncingScrollPhysics(),
        child: SlideTransition(
          position: _animationManager.sliderAnimationRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(50.h),
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
                  titleGetPassword,
                  style: AppTextStyle.size24,
                  textAlign: TextAlign.center,
                ),
              ),
              Gap(5.h),
              SlideTransition(
                position: _animationManager.sliderAnimationRight,
                child: Text(
                  desGetPassword,
                  style: AppTextStyle.size14.copyWith(color: AppColor.black),
                  textAlign: TextAlign.center,
                ),
              ),
              Gap(50.h),
              SlideTransition(
                position: _animationManager.sliderAnimationLeft,
                child: TextFormFieldWidget(
                  hintText: enterYourEmail,
                  title: email,
                  controller: TextEditingController(),
                  myValidator: (text) => null,
                ),
              ),
              Gap(24.h),
              SlideTransition(
                position: _animationManager.sliderAnimationBottom,
                child: MaterialButtonWidget(
                  onPressed: () {
                    context.pushNamed(ForgetPassVerifyCode.routeName);
                  },
                  title: Text(getPassword),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
