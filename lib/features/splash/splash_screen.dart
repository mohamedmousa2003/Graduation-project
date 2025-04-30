import 'package:final_project_bfcai/core/constant/app_text.dart';
import 'package:final_project_bfcai/core/constant/images_assets.dart';
import 'package:final_project_bfcai/features/onboriding/pages/onboriding_Screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName ="splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void intiState(){
    Future.delayed(
      Duration(seconds: 3),(){
        Navigator.pushReplacementNamed(context, OnboardingScreen.routeName);
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImagePng.logo),
            Gap(15),
            Text(logo,
              style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),),
          ],
        ),
      ),
    );
  }
}
