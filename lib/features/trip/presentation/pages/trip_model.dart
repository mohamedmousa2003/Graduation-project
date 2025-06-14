import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../model/api_manager.dart';// تأكد من وجود هذا الملف أو الكلاس
import '../../../../widget/custom_dialog.dart';
import '../../../../widget/text_form.dart';
import '../../logic/TripPlan.dart';
import '../pages/plan_trip_screen.dart';

class TripModel extends StatefulWidget {
  static const String routeName = 'TripModel';

  const TripModel({super.key});

  @override
  State<TripModel> createState() => _TripModelState();
}

class _TripModelState extends State<TripModel> {
  final TextEditingController numberOfDay = TextEditingController();
  final TextEditingController enterBudget = TextEditingController();

  Future<TripPlan> getTrip() async {
    return await getTripPlan(RequestPlanTrip(
      int.parse(numberOfDay.text),
      double.parse(enterBudget.text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trip Planner', style: AppTextStyle.size24),
            Gap(8.h),
            Text(
              'Discover the beauty of Egypt',
              style: AppTextStyle.size14.copyWith(color: AppColor.black),
            ),
            Gap(25.h),
            TextFormFieldWidget(
              hintText: 'Enter number of days',
              title: 'Number of Days',
              prefixIcon: Icon(Icons.numbers, size: 25),
              controller: numberOfDay,
              myValidator: (text) => null,
            ),
            Gap(15.h),
            TextFormFieldWidget(
              hintText: 'Enter your budget',
              title: 'Budget',
              prefixIcon: Icon(Icons.attach_money_outlined, size: 28),
              controller: enterBudget,
              myValidator: (text) => null,
            ),
            Gap(50.h),
            MaterialButtonWidget(
              onPressed: () {
                getTrip().then((tripPlan) {
                  Navigator.pushNamed(
                    context,
                    PlanTripScreen.routeName,
                    arguments: tripPlan,
                  );
                }).catchError((error) {
                  print("Error: $error");
                });
              },
              title: const Text("My Trip"),
            ),
          ],
        ),
      ),
    );
  }
}
