import 'package:final_project_bfcai/core/utils/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';

class CustomCard extends StatelessWidget {
  final String name;
  final TextStyle? textStyle;
  final Color? borderColor;

  const CustomCard({
    super.key,
    required this.name,
    this.textStyle,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: borderColor ?? AppColor.gray,
          width: 2,
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        name,
        style: textStyle ?? AppTextStyle.size18.copyWith(
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
