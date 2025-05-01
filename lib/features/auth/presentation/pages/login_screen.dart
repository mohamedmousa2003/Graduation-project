import 'dart:developer';
import 'package:final_project_bfcai/core/extensions/context_extention.dart';
import 'package:final_project_bfcai/features/auth/presentation/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/constant/icons_assets.dart';
import '../../../../core/enums/typ_click_auth.dart';
import '../../../../core/helper/observer.dart';
import '../../../../core/providers/animation_provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/const.dart';
import '../../../../widget/custom_dialog.dart';
import '../../../../widget/text_form.dart';
import '../widget/haveornotaccount.dart';
import 'forgetpassword.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  const LoginScreen({super.key, this.typClickAuth});

  final TypClickAuth? typClickAuth;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin, RouteAware {
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
    log(widget.typClickAuth.toString());
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SlideTransition(
              position: _animationManager.sliderAnimationLeft,
              child: Row(
                children: [
                  Text(welcomeLoginBack, style: AppTextStyle.size24),
                  Gap(8.w),
                  Image.asset(
                    IconsPng.welcomeBack,
                    width: 30.w,
                    height: 30.h,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            Gap(8.h),
            SlideTransition(
              position: _animationManager.sliderAnimationRight,
              child: Text(
                desWelcomeBack,
                style: AppTextStyle.size14.copyWith(color: AppColor.black),
              ),
            ),
            Gap(40.h),
            SlideTransition(
              position: _animationManager.sliderAnimationLeft,
              child: TextFormFieldWidget(
                hintText: enterYourEmail,
                title: email,
                controller: TextEditingController(),
                myValidator: (text) => null,
              ),
            ),
            Gap(20.h),
            SlideTransition(
              position: _animationManager.sliderAnimationRight,
              child: TextFormFieldWidget(
                hintText: " * * * * * * * *",
                isPassword: true,
                obscureText: true,
                title: password,
                controller: TextEditingController(),
                myValidator: (text) => null,
              ),
            ),
            Gap(12.h),
            SlideTransition(
              position: _animationManager.sliderAnimationLeft,
              child: GestureDetector(
                onTap: () {
                  context.pushNamed(ForgetPasswordScreen.routeName);
                },
                child: Text(
                  textAlign: TextAlign.right,
                  forgotPassword,
                  style: AppTextStyle.size14.copyWith(
                    color: AppColor.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor.primary,
                  ),
                ),
              ),
            ),
            Gap(40.h),
            SlideTransition(
                position: _animationManager.sliderAnimationRight,
                child: MaterialButtonWidget(onPressed: () {}, title: login)),
            Gap(30.h),
            SlideTransition(
              position: _animationManager.sliderAnimationBottom,
              child: HaveOrNotAccount(
                question: noHaveAccount,
                navigateTo: register,
                onTap: () {
                  context.pushNamedAndRemoveUntil(RegisterScreen.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
