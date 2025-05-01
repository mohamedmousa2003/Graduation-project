import 'package:final_project_bfcai/core/extensions/context_extention.dart';
import 'package:final_project_bfcai/features/auth/presentation/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../../core/constant/icons_assets.dart';
import '../../../../core/helper/observer.dart';
import '../../../../core/providers/animation_provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/const.dart';// تأكد ان عندك فايل AppNavigatorObserver
import '../../../../widget/custom_dialog.dart';
import '../../../navigation/presentation/pages/navigation.dart';
import 'login_screen.dart';

class SelectAuth extends StatefulWidget {
  static const String routeName = 'select';

  const SelectAuth({super.key});

  @override
  State<SelectAuth> createState() => _SelectAuthState();
}

class _SelectAuthState extends State<SelectAuth> with TickerProviderStateMixin, RouteAware {
  late AnimationManager _animationManager;

  @override
  void initState() {
    super.initState();
    _animationManager = AnimationManager();
    _animationManager.initialize(this, const Duration(seconds: 1));
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
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SlideTransition(
              position: _animationManager.sliderAnimationTop,
              child: SvgPicture.asset(IconsSvg.getStare),
            ),
            Gap(50.h),
            SlideTransition(
              position: _animationManager.sliderAnimationLeft,
              child: MaterialButtonWidget(
                onPressed: () {
                  context.pushNamed(RegisterScreen.routeName);
                },
                title: createAccount,
              ),
            ),
            Gap(20.h),
            SlideTransition(
              position: _animationManager.sliderAnimationRight,
              child: MaterialButtonWidget(
                onPressed: () {
                  context.pushNamed(LoginScreen.routeName);
                },
                title: "LOGIN",
                haveBorder: true,
                colorBackground: Colors.white,
                colorText: AppColor.primary,
              ),
            ),
            Gap(30.h),
            SlideTransition(
              position: _animationManager.sliderAnimationBottom,
              child: GestureDetector(
                onTap: () {
                  context.pushNamedAndRemoveUntil(MainControllerScreens.routeName);
                },
                child: Text(
                  guest,
                  style: AppTextStyle.size18.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColor.primary,
                  ),
                ),
              ),
            ),
            Gap(50.h),
          ],
        ),
      ),
    );
  }
}
