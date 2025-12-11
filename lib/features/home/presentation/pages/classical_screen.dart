import 'package:final_project_bfcai/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../model/ClassicalPlace.dart';
import '../../../../provider/my_provider.dart';
import '../../../../test.dart';
import '../../../../widget/custom_location.dart';
import '../../classical_place/data/models/classical_place.dart';
import '../widgets/custom_rating.dart';

class ClassicalDetailScreen extends StatelessWidget {
  final ClassicalPlace place;

  const ClassicalDetailScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    var favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isFavorite = favoritesProvider.isFavorite(place);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              favoritesProvider.toggleFavorite(place);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${place.name} removed from favorites'),
                  duration: Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: AppColor.green,
                  margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: MediaQuery.of(context).size.height / 2.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              );
            },
          ),

        ],
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
