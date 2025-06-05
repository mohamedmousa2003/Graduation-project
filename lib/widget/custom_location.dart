import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/app_text_style.dart';

class LocationRow extends StatelessWidget {
  final String location;
  final double sizeNum;
  final double textNum;

  const LocationRow({
    super.key,
    required this.location,
    this.sizeNum = 26,
    this.textNum = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
            Icons.location_on_outlined,
            color: AppColor.black,
            size: sizeNum,
        ),
        Gap(3.w),
        Expanded(
          child: Text(
          
            location,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: AppTextStyle.size18.copyWith(
                fontWeight: FontWeight.bold,
              fontSize: textNum,
            ),
          
          ),
        ),

      ],
    );
  }
}

