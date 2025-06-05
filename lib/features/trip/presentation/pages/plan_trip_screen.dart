import 'package:final_project_bfcai/core/constant/images_assets.dart';
import 'package:final_project_bfcai/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/const.dart';
import '../../../../widget/custom_location.dart';

class PlanTripScreen extends StatelessWidget {
  static const String routeName= "planTrip";
  const PlanTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
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
            Text(day ,style: AppTextStyle.size24),

            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 30.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: AppColor.grayCard
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 40.h,
                  color: AppColor.primary,
                    child: Padding(
                      padding:  EdgeInsets.only(top: 4.h,left: 20.w),
                      child: Text(
                        day ,style: AppTextStyle.size24.copyWith(
                        color: AppColor.white
                      ),),
                    ),
                  ),
                  Gap(5.h),
                  Image.asset(
                    width: double.infinity,
                    fit: BoxFit.fill,
                    ImagePng.shimmerOne,
                  ),
                  Row(
                    children: [
                      _designCard(
                        text: "9 AM - 7 PM",
                        icon: Icons.access_time,
                      ),
                      Gap(8.w),
                      _designCard(
                        text: "200",
                        icon: Icons.monetization_on_outlined,
                      ), _designCard(
                        text: "200",
                        icon: Icons.access_time,
                      ),
                    ],
                  ),
                  LocationRow(
                    location: "Hurghada",sizeNum: 30,textNum: 22,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _designCard({
    required IconData icon,
    required String text,
  }) {
    return Container(

      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColor.white,
      ),
      child: Row(
        children: [
          Icon(icon),
          Gap(8.w),
          Text(text, style: AppTextStyle.size18),
        ],
      ),
    );
  }

}
