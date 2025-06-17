import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../model/api_manager.dart';
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false; // ✅ للحالة أثناء التحميل

  Future<TripPlan> getTrip() async {
    return await getTripPlan(
      RequestPlanTrip(
        int.parse(numberOfDay.text),
        double.parse(enterBudget.text),
      ),
    );
  }

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final tripPlan = await getTrip();
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlanTripScreen(tripPlan: tripPlan),
          ),
        );
      } catch (error) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong: $error')),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please correct the errors in the form')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Form(
          key: _formKey,
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
                prefixIcon: const Icon(Icons.numbers, size: 25),
                controller: numberOfDay,
                myValidator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter number of days';
                  }
                  if (int.tryParse(text) == null || int.parse(text) <= 0) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
              ),
              Gap(15.h),
              TextFormFieldWidget(
                hintText: 'Enter your budget',
                title: 'Budget',
                prefixIcon: const Icon(Icons.attach_money_outlined, size: 28),
                controller: enterBudget,
                myValidator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter your budget';
                  }
                  if (double.tryParse(text) == null ||
                      double.parse(text) <= 0) {
                    return 'Enter a valid budget';
                  }
                  return null;
                },
              ),
              Gap(50.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      :  Text(
                    "My Trip",
                    style: AppTextStyle.size18.copyWith(
                      color: AppColor.white,
                      fontWeight:  FontWeight.bold,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
