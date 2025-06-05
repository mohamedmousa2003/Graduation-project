import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/constant/font_family_helper.dart';
import '../../../../core/constant/icons_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';

class BuildNewPhoneNumberSection extends StatelessWidget {
  final String phoneNumber;
  final String hintText;
  final VoidCallback onTap;

  const BuildNewPhoneNumberSection({
    super.key,
    required this.phoneNumber,
    required this.onTap,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            hintText,
            style: AppTextStyle.size12.copyWith(color: AppColor.gray),
          ),
        ),
        Gap(2.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(40.r),
              border: Border.all(color: const Color(0xFFECECEC), width: 1.w),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const ContainerFlagWidget(),
                    Text(
                      phoneNumber,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w300,
                        fontFamily: FontFamilyHelper.mantserratEnglish,
                        color: AppColor.gray,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10.0.w),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColor.primary,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ContainerFlagWidget extends StatelessWidget {
  final String countryCode;
  final String flagAsset;

  const ContainerFlagWidget({
    super.key,
    this.countryCode = '+967',
    this.flagAsset = IconsPng.flag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105.w,
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: Row(
          textDirection: TextDirection.ltr,
          children: [
            VerticalDivider(
              color: const Color(0xFFECECEC),
              width: 2,
              endIndent: MediaQuery.of(context).size.height / 80,
              indent: MediaQuery.of(context).size.height / 80,
            ),
            SizedBox(width: 4.w),
            Image.asset(flagAsset, width: 32.w, height: 21.h, fit: BoxFit.fill),
            SizedBox(width: 4.w),
            Text(
              countryCode,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.black,
              ),
              textDirection: TextDirection.ltr,
            ),
          ],
        ),
      ),
    );
  }
}
