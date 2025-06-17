import 'package:final_project_bfcai/core/extensions/context_extention.dart';
import 'package:final_project_bfcai/features/favourites/presentation/pages/favourites_screen.dart';
import 'package:final_project_bfcai/features/profile_screen/presentation/pages/profile_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../../core/constant/icons_assets.dart';
import '../../../../core/constant/images_assets.dart';
import '../../../../core/constant/shared_pref.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/const.dart';
import '../../../../widget/custom_dialog.dart';
import '../../../auth/presentation/pages/forget_pass_create_new_password_screen.dart';
import '../../../auth/presentation/pages/login_screen.dart';
import '../../../auth/presentation/pages/select_auth.dart';
import '../widget/design_image.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(20.h),
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.primary, AppColor.primary.withOpacity(0.7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTap: () => context.pushNamed(ProfileImageSetting.routeName),
                      child: CircleAvatar(
                        radius: 45.r,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: DesignImage(
                            width: 80.w,
                            height: 80.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(12.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        SharedPrefsService.getString("name")??"name",
                        style: AppTextStyle.size20.copyWith(
                          color: AppColor.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        SharedPrefsService.getString("email")??"email",
                        style: AppTextStyle.size16.copyWith(
                          color: AppColor.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(30.h),

            // Settings Title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                setting,
                style: AppTextStyle.size21.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary,
                ),
              ),
            ),
            Gap(16.h),

            // Settings Card
            Container(
              decoration: BoxDecoration(
                color: AppColor.grayCard,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  buildProfileItem(
                    title: favourites,
                    icon: Icons.favorite_border,
                    onTap: () => Navigator.pushNamed(context, FavouritesScreen.routeName),
                  ),
                  buildProfileItem(
                    title: signOut,
                    icon: Icons.logout,
                    onTap: () => _showUnfollowDialog(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet(
    BuildContext context,
    String selectedLanguage,
    Function(String) onLanguageSelected,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 52.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFECECEC),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  Gap(16.h),

                  Gap(10.h),

                  Gap(10.h),

                  Gap(20.h),
                  MaterialButtonWidget(
                    title: Text(saveAndChange),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    colorBackground: AppColor.primary,
                    colorText: AppColor.white,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildProfileItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
      leading: Icon(icon, color: AppColor.primary),
      title: Text(
        title,
        style: AppTextStyle.size18.copyWith(fontWeight: FontWeight.w500),
      ),
      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20, color: AppColor.gray),
      onTap: onTap,
    );
  }


  Widget designCard({
    required VoidCallback onTap,
    required String title,
    Widget? trailing,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        title: Text(title, style: AppTextStyle.size18),
        trailing:
            trailing ?? const Icon(Icons.arrow_forward_ios_outlined, size: 30),
      ),
    );
  }

  // Show logout
  void _showUnfollowDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => CustomDialog(
            widthICon: 56,
            heightICon: 56,
            title: sureYouWantToLogOut,
            content: willLoggedOutApp,
            confirmText: logout,
            onCancel: () => context.pop(),
            onConfirm: () {
              SharedPrefsService.clearAll("token");
              context.pushNamedAndRemoveUntil(SelectAuth.routeName);
            },
            confirmBackgroundColor: AppColor.primary,
            cancelBackgroundColor: AppColor.grayCard,
            cancelHaveBorder: false,
            iconPath: ImagePng.logo,
          ),
    );
  }
}
