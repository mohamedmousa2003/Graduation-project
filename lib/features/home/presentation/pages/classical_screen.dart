import 'package:final_project_bfcai/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../model/ClassicalPlace.dart';
import '../../../../test.dart';
import '../../../../widget/custom_location.dart';
import '../widgets/custom_rating.dart';

class ClassicalDetailScreen extends StatelessWidget {
  final ClassicalPlace place;

  const ClassicalDetailScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(place.name ?? '',style: AppTextStyle.size24,),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                place.imageUrl ?? '',
                width: double.infinity,
                height: 220.h,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
              ),
              Gap(8.h),
              LocationRow(location: place.address ?? ""),
              Gap(5.h),
              RatingRow(rating: place.rating != null ? double.tryParse(place.rating.toString()) ?? 0.0 : 0.0,),
              Gap(5.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'EGY',
                      style: AppTextStyle.size18.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      place.cost.toString() ,
                      style: AppTextStyle.size18.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(5.h),

              Text(place.type ?? "",style: AppTextStyle.size18.copyWith(
                fontWeight: FontWeight.bold,
              ),
              ),
              Gap(8.h),
              Text(place.description ?? "",style: AppTextStyle.size16.copyWith(
                height: 1.5,
              ),
                textAlign: TextAlign.start,
                softWrap: true,),
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
