import 'package:final_project_bfcai/core/extensions/context_extention.dart';
import 'package:final_project_bfcai/features/trip/presentation/pages/plan_trip_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/const.dart';
import '../../../../widget/custom_dialog.dart';
import '../../../../widget/text_form.dart';
import '../../../auth/presentation/pages/forget_pass_verify_code_screen.dart';

class TripModel extends StatelessWidget {
  static const String routeName = 'Trip Model';
  const TripModel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w ,vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tripPlanner, style: AppTextStyle.size24),
            Gap(8.h),
            Text(
              discoverEgypt,
              style: AppTextStyle.size14.copyWith(color: AppColor.black),
            ),
            Gap(25.h),
            TextFormFieldWidget(
              hintText: yourNumber,
              title: numberOfDAy,
              prefixIcon:Icon(Icons.numbers,size: 25,),
              controller: TextEditingController(),
              myValidator: (text) => null,
            ),
            Gap(15.h),
            TextFormFieldWidget(
              hintText: yourBudget,
              title: budget,
              prefixIcon:Icon(Icons.attach_money_outlined,size: 28,),
              controller: TextEditingController(),
              myValidator: (text) => null,
            ),
            Gap(50.h),
            MaterialButtonWidget(
              onPressed: () {
                context.pushNamed(PlanTripScreen.routeName);
              },
              title: Text(myTrip),
            ),
          ],
        ),
      ),
    );
  }
}
