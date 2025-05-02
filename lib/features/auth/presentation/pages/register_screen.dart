import 'package:final_project_bfcai/core/extensions/context_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/enums/typ_click_auth.dart';
import '../../../../core/helper/observer.dart';
import '../../../../core/providers/animation_provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/const.dart';
import '../../../../widget/custom_dialog.dart';
import '../../../../widget/text_form.dart';
import '../widget/haveornotaccount.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  const RegisterScreen({super.key, this.typClickAuth});

  final TypClickAuth? typClickAuth;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with TickerProviderStateMixin, RouteAware {
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SlideTransition(
                position: _animationManager.sliderAnimationLeft,
                child: Text(welcomeRegisterBack, style: AppTextStyle.size24)),
            Gap(8.h),
            SlideTransition(
              position: _animationManager.sliderAnimationRight,
              child: Text(
                desWelcomeRegisterBack,
                style: AppTextStyle.size14.copyWith(color: AppColor.black),
              ),
            ),
            Gap(40.h),
            SlideTransition(
              position: _animationManager.sliderAnimationLeft,
              child: TextFormFieldWidget(
                hintText: enterYourFullName,
                title: fullName,
                controller: TextEditingController(),
                myValidator: (text) => null,
              ),
            ),
            Gap(12.h),
            SlideTransition(
              position: _animationManager.sliderAnimationRight,
              child: TextFormFieldWidget(
                hintText: enterYourEmail,
                title: email,
                controller: TextEditingController(),
                myValidator: (text) => null,
              ),
            ),
            Gap(12.h),
            SlideTransition(
              position: _animationManager.sliderAnimationLeft,
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
              position: _animationManager.sliderAnimationRight,
              child: TextFormFieldWidget(
                hintText: " * * * * * * * *",
                isPassword: true,
                obscureText: true,
                title: confirmPassword,
                controller: TextEditingController(),
                myValidator: (text) => null,
              ),
            ),
            Gap(40.h),
            SlideTransition(
              position: _animationManager.sliderAnimationLeft,
              child: MaterialButtonWidget(
                onPressed: () {
                  //context.pushNamed(VerificationCodeScreen.routeName);
                },
                title: register,
              ),
            ),
            Gap(30.h),
            SlideTransition(
              position: _animationManager.sliderAnimationBottom,
              child: HaveOrNotAccount(
                question: haveAccount,
                navigateTo: login,
                onTap: () {
                  context.pushNamedAndRemoveUntil(LoginScreen.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
