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
import 'login_screen.dart';

class CongratsScreen extends StatefulWidget {
  static const String routeName = '/congrats-screen';

  const CongratsScreen({super.key});

  @override
  State<CongratsScreen> createState() => _CongratsScreenState();
}

class _CongratsScreenState extends State<CongratsScreen> with TickerProviderStateMixin, RouteAware {
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(60.h),
            SlideTransition(
              position: _animationManager.sliderAnimationTop,
              child: SvgPicture.asset(
                color: AppColor.primary,
                IconsSvg.congratulations,
                width: 80.w,
                height: 80.h,
              ),
            ),
            Gap(8.h),
            SlideTransition(
              position: _animationManager.sliderAnimationLeft,
              child: Text(
                congratulations,
                style: AppTextStyle.size24,
                textAlign: TextAlign.center,
              ),
            ),
            Gap(5.h),
            //desCongratulations
            SlideTransition(
              position: _animationManager.sliderAnimationRight,
              child: Text(
                desCongratulations,
                style: AppTextStyle.size14.copyWith(color: AppColor.grayWhite),
                textAlign: TextAlign.center,
              ),
            ),
            Gap(20.h),
            SlideTransition(
              position: _animationManager.sliderAnimationBottom,
              child: MaterialButtonWidget(
                onPressed: () {
                  context.pushNamedAndRemoveUntil(LoginScreen.routeName);
                },
                title: Text(login),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
