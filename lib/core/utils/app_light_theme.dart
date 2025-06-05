import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_style.dart';

abstract class AppLightTheme {
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: AppColor.backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.backgroundColor,
      centerTitle: true,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColor.primary, size: 30),
      titleTextStyle: AppTextStyle.size21.copyWith(fontWeight: FontWeight.bold),
    ),
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: AppColor.gray,
      labelColor: AppColor.primary,
      indicatorColor: AppColor.primary,
      dividerColor: Colors.transparent,
      labelStyle: AppTextStyle.size18,
      unselectedLabelStyle: AppTextStyle.size18,
      dividerHeight: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      selectedItemColor: AppColor.primary,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      unselectedItemColor: AppColor.gray,
      selectedLabelStyle: AppTextStyle.size14.copyWith(
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: AppTextStyle.size14,
    ),
  );
}
