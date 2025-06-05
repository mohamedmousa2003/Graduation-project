import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';

class HaveOrNotAccount extends StatelessWidget {
  final String question;
  final String navigateTo;
  final void Function()? onTap;

  const HaveOrNotAccount({
    super.key,
    required this.question,
    required this.onTap,
    required this.navigateTo,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              style: AppTextStyle.size14.copyWith(color: AppColor.black),
              text: question,
              children: [
                TextSpan(
                  text: '  $navigateTo',
                  style: AppTextStyle.size14.copyWith(
                    color: AppColor.primary,
                    fontWeight: FontWeight.bold,
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
