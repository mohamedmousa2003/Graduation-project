import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
class RatingRow extends StatelessWidget {
  final double rating;
  final bool showOnlyOneStar;
  final double sizeNum;
  final double sizeText;

  const RatingRow({
    super.key,
    this.sizeNum = 30,
    this.sizeText = 20,
    required this.rating,
    this.showOnlyOneStar = false,
  });

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    return Row(
      children: [
        if (showOnlyOneStar)
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: Icon(Icons.star_rate_rounded, color: AppColor.yellow, size: sizeNum,),
          )
        else ...[
          // full stars
          for (int i = 0; i < fullStars; i++)
            Icon(Icons.star_rate_rounded, color: AppColor.yellow, size: sizeNum),
          // half star
          if (hasHalfStar)
            Icon(Icons.star_half_rounded, color: AppColor.yellow, size: sizeNum),
        ],
        Gap(8.w),
        Text(
          rating.toString(),
          style: AppTextStyle.size18.copyWith(
              fontWeight: FontWeight.bold,
            fontSize: sizeText,
          ),
        ),
        Gap(2.w),
      ],
    );
  }
}

