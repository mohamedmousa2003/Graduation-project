import 'package:flutter/material.dart';
import '../../core/constant/shared_pref.dart';
import '../../core/providers/animation_provider.dart';
import '../../core/constant/images_assets.dart';
import '../../features/onboarding/presentation/pages/onboarding_view.dart';
import '../../core/utils/app_colors.dart';
import '../navigation/presentation/pages/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = "splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationManager animationManager;

  @override
  void initState() {
    super.initState();
    animationManager = AnimationManager();
    animationManager.initialize(this,Duration(seconds: 3));

    Future.delayed(Duration(seconds: 4), () {
      if(SharedPrefsService.getString("token")!=null){
        Navigator.pushReplacementNamed(context, MainControllerScreens.routeName);
      }else {
        Navigator.pushReplacementNamed(context, OnboardingView.routeName);
      }// انتقل للصفحة التالية
    });
  }

  @override
  void dispose() {
    animationManager.dispose();  // تعطيل الأنيميشنات
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Center(
        child: animationManager.isInitialized
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: animationManager.sliderAnimationTop,
              builder: (context, child) {
                return SlideTransition(
                  position: animationManager.sliderAnimationTop,
                  child: Image.asset(
                    ImagePng.logo,
                    fit: BoxFit.fill,
                    height: 100,
                    width: 100,
                  ),
                );
              },
            ),
            SizedBox(height: 24),
            // عرض الأنيميشن السفلي
            AnimatedBuilder(
              animation: animationManager.sliderAnimationBottom,
              builder: (context, child) {
                return SlideTransition(
                  position: animationManager.sliderAnimationBottom,
                  child: Text(
                    "A M U N",
                    style: TextStyle(
                      fontSize: 24,
                      color: Color(0xff2E2D2A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ],
        )
            : CircularProgressIndicator(), // عرض مؤشر التحميل إذا لم تكن الأنيميشنات جاهزة
      ),
    );
  }
}
