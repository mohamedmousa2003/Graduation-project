import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../core/constant/font_family_helper.dart';
import '../core/constant/icons_assets.dart';
import '../core/utils/app_colors.dart';
import '../core/utils/app_text_style.dart';

typedef Validator = String? Function(String?);

class TextFormFieldWidget extends StatefulWidget {
  final String title;
  final String hintText;
  final TextInputType keyboardType;
  bool obscureText;
  final bool isPassword;
  final TextEditingController controller;
  final Validator myValidator;
  final bool? enabled;
  bool isPhone;
  final double horizontalPadding;
  final double verticalPadding;
  final TextStyle? textStyle;
  final Widget? prefixIcon; // ✅ أضفنا هذا

  TextFormFieldWidget({
    required this.title,
    required this.controller,
    required this.myValidator,
    this.horizontalPadding = 10.0,
    this.verticalPadding = 7.0,
    this.textStyle,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.isPhone = false,
    this.isPassword = false,
    super.key,
    this.enabled,
    this.prefixIcon, // ✅ أضفنا هذا
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            widget.title,
            style: widget.textStyle ?? AppTextStyle.size16,
          ),
        ),
        Gap(widget.verticalPadding.h),
        TextFormField(
          enabled: widget.enabled ?? true,
          // inputFormatters: [
          //   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@*\-_]')),
          // ],
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            fontFamily: FontFamilyHelper.mantserratEnglish,
            color: widget.enabled == false ? AppColor.gray : AppColor.black,
          ),
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamilyHelper.mantserratEnglish,
              color: AppColor.gray,
            ),
            fillColor: Colors.white,
            filled: true,
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                widget.obscureText
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: AppColor.gray,
                size: 25.sp,
              ),
              onPressed: () {
                setState(() {
                  widget.obscureText = !widget.obscureText;
                });
              },
            )
                : null,
            prefixIcon: widget.isPhone
                ? const ContainerFlagWidget()
                : widget.prefixIcon,
            prefixIconColor: AppColor.gray,
            contentPadding:  EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            enabledBorder: outlineInputBorder(color: AppColor.gray, width: 1),
            disabledBorder: outlineInputBorder(color: AppColor.gray, width: 1),
            focusedBorder:
            outlineInputBorder(color: AppColor.primary, width: 2),
            errorBorder: outlineInputBorder(color: AppColor.red, width: 1),
            focusedErrorBorder:
            outlineInputBorder(color: AppColor.red, width: 1),
          ),
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          validator: widget.myValidator,
        ),
      ],
    );
  }

  OutlineInputBorder outlineInputBorder({
    required Color color,
    required double width,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(40.r),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}

class ContainerFlagWidget extends StatelessWidget {
  const ContainerFlagWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 105.w,
      child: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: Row(
          textDirection: TextDirection.ltr,
          children: [
            Text(
              '+967',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamilyHelper.mantserratEnglish,
                color: AppColor.black,
              ),
              textDirection: TextDirection.ltr,
            ),
            SizedBox(width: 4.w),
            Image.asset(
              IconsPng.flag,
              width: 32.w,
              height: 21.h,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ),
    );
  }
}
