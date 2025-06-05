import 'package:final_project_bfcai/core/extensions/context_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/helper/observer.dart';
import '../../../../core/providers/animation_provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/const.dart';
import '../../../auth/presentation/pages/select_auth.dart';
import 'Onboarding_items.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});
  static const String routeName = "OnboardingView";

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> with TickerProviderStateMixin, RouteAware {
  final controller = OnboardingItems();
  final pageController = PageController();
  bool lastPage = false;
  late AnimationManager _animationManager;

  @override
  void initState() {
    super.initState();
    _animationManager = AnimationManager();
    _animationManager.initialize(this, const Duration(seconds: 3));
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
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: PageView.builder(
        itemCount: controller.items.length,
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            lastPage = controller.items.length - 1 == value;
          });

        },
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              top: mediaQuery.height * 0.07,
              left: 15,
              right: 15,
              bottom: mediaQuery.height * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                index != 2
                    ? Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      pageController.jumpToPage(controller.items.length - 1);
                    },
                    child: Text(
                      skip,
                      style: AppTextStyle.size16.copyWith(color: AppColor.primary),
                    ),
                  ),
                )
                    : SizedBox(height: mediaQuery.height * 0.01.h),
                Padding(
                  padding: EdgeInsets.only(top: mediaQuery.height * 0.01.h),
                ),
                // استخدم الأنيميشن من AnimationManager
                SlideTransition(
                  position: _animationManager.sliderAnimationLeft,
                  child: SvgPicture.asset(controller.items[index].image),
                ),
                SizedBox(height: mediaQuery.height * 0.01),
                SmoothPageIndicator(
                  controller: pageController,
                  count: controller.items.length,
                  effect: SlideEffect(
                    spacing: 15.0.w,
                    radius: 5.0.r,
                    dotWidth: 32.28.w,
                    dotHeight: 8.0.h,
                    strokeWidth: 1.5,
                    dotColor: AppColor.white,
                    activeDotColor: AppColor.primary,
                  ),
                  onDotClicked: (index) {
                    pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                    );
                  },
                ),
                SizedBox(height: mediaQuery.height * 0.03),
                // العنوان مع أنيميشن من اليمين
                SlideTransition(
                  position: _animationManager.sliderAnimationRight,
                  child: Text(
                    controller.items[index].title,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.size24,
                  ),
                ),
                SizedBox(height: mediaQuery.height * 0.02),
                // الوصف مع أنيميشن من اليسار
                SlideTransition(
                  position: _animationManager.sliderAnimationLeft,
                  child: Text(
                    controller.items[index].description,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.size14,
                  ),
                ),
                // SizedBox(height: mediaQuery.height * 0.1.h),
                // أزرار التنقل
                SlideTransition(
                  position: _animationManager.sliderAnimationBottom,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      index != 0
                          ? TextButton(
                        onPressed: () {
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        },
                        child: Text(
                          back,
                          style: AppTextStyle.size16.copyWith(color: AppColor.primary),
                        ),
                      )
                          : Container(),
                      index != controller.items.length - 1
                          ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        onPressed: () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        },
                        child: Text(
                          next,
                          style: AppTextStyle.size16.copyWith(color: AppColor.white),
                        ),
                      )
                          : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primary,
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 13.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        onPressed: () {
                          context.pushNamedAndRemoveUntil(SelectAuth.routeName);
                        },
                        child: Text(
                          getStarted,
                          style: AppTextStyle.size16.copyWith(color: AppColor.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
