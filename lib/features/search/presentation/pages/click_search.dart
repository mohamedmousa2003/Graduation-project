import 'package:final_project_bfcai/core/utils/app_text_style.dart';
import 'package:final_project_bfcai/model/SearchPlace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../test.dart';
import '../../../../widget/custom_location.dart';

class ClickSearch extends StatelessWidget {
  final TouristSpots place;

  const ClickSearch({super.key, required this.place});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(place.name ?? '',style: AppTextStyle.size24,),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              place.image ?? '',
              width: double.infinity,
              height: 220.h,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
            ),
            Gap(8.h),
            LocationRow(location: place.city ?? ""),
            Gap(5.h),

            Gap(5.h),

            Text(place.address ?? "",style: AppTextStyle.size18.copyWith(
              fontWeight: FontWeight.bold,
            ),
            ),
            Gap(8.h),

            const SizedBox(height: 8),
            MyGoogleMapLink(text: place.name?? "",),
            const SizedBox(height: 8),
            MyGoogleLink(text: place.name?? "",),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
