import 'package:final_project_bfcai/core/extensions/context_extention.dart';
import 'package:final_project_bfcai/features/profile_screen/presentation/pages/profile_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../../core/constant/icons_assets.dart';
import '../../../../core/constant/images_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/const.dart';
import '../../../../widget/custom_dialog.dart';
import '../../../auth/presentation/pages/forget_pass_create_new_password_screen.dart';
import '../../../auth/presentation/pages/login_screen.dart';
import '../widget/design_image.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    String selectedLanguage = "ar";
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 9.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(10.h),
            Container(
              height: 132.h,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  bottomRight: Radius.circular(24.r),
                ),
              ),
              child: Row(
                children: [
                  Gap(15.w),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(ProfileImageSetting.routeName);
                    },
                    child: DesignImage(
                      width: 110.w,
                      height: 150.h,
                    ),
                  ),
                  Gap(15.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Mohamed Mousa",
                          style: AppTextStyle.size21.copyWith(
                            color: AppColor.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Text(
                        //   "mohamedmousa@gmail.com",style: AppTextStyle.size14.copyWith(
                        //   color: AppColor.white,
                        //   overflow: TextOverflow.ellipsis,
                        // ),),
                      ],
                    ),
                  ),
                  Gap(30.h),
                ],
              ),
            ),
            Gap(30.h),
            _buildSectionTitle(setting),
            _buildSettingsContainer(
              children: [
                designCard(
                  title: changePassword,
                  onTap: () {
                    context.pushNamed(
                      ForgetPassCreateNewPasswordScreen.routeName,
                    );
                  },
                ),
                designCard(
                  title: favourites,
                  onTap: () {
                    // Navigator.pushNamed(context,ChangePassword.routeName);
                  },
                ),
                designCard(
                  title: language,
                  onTap: () {
                    showLanguageBottomSheet(context, selectedLanguage, (
                      newLanguage,
                    ) {
                      setState(() {
                        selectedLanguage = newLanguage;
                      });
                    });
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        selectedLanguage == "ar" ? english : arabic,
                        style: AppTextStyle.size16.copyWith(
                          color: AppColor.primary,
                          decorationThickness: 2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios_outlined, size: 30),
                    ],
                  ),
                ),
              ],
            ),
            Gap(30.h),
            _buildSectionTitle(help),
            _buildSettingsContainer(
              children: [
                designCard(
                  title: signOut,
                  onTap: () {
                    return _showUnfollowDialog(context);
                  },
                ),
                designCard(
                  title: privacyPolicy,
                  onTap: () {
                    // Navigator.pushNamed(context,ChangePassword.routeName);
                  },
                ),
                designCard(
                  title: version,
                  onTap: () {
                    // Navigator.pushNamed(context,ChangePassword.routeName);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        title,
        style: AppTextStyle.size21.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColor.primary,
        ),
      ),
    );
  }

  Widget _buildSettingsContainer({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Column(children: children),
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
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 25.h,
                          width: 25.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColor.primary,
                              width: 1.5,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              IconsSvg.cancelProfile,
                              color: AppColor.primary,
                              height: 15.h,
                              width: 15.w,
                            ),
                          ),
                        ),
                      ),
                      Gap(12.h),
                      Text(
                        language,
                        style: AppTextStyle.size18.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                  Gap(10.h),
                  _buildLanguageOption(
                    context,
                    arabic,
                    "ar",
                    selectedLanguage == "ar",
                    (newLang) {
                      setState(() {
                        selectedLanguage = newLang;
                      });
                    },
                  ),
                  Gap(10.h),
                  _buildLanguageOption(
                    context,
                    english,
                    "en",
                    selectedLanguage == "en",
                    (newLang) {
                      setState(() {
                        selectedLanguage = newLang;
                      });
                    },
                  ),
                  Gap(20.h),
                  MaterialButtonWidget(
                    title: saveAndChange,
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

  Widget _buildLanguageOption(
    BuildContext context,
    String title,
    String value,
    bool isSelected,
    Function(String) onLanguageSelected,
  ) {
    return GestureDetector(
      onTap: () => onLanguageSelected(value),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColor.primary : AppColor.grayWhite,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyle.size16),
            isSelected
                ? const Icon(
                  Icons.radio_button_checked,
                  color: AppColor.primary,
                )
                : const Icon(Icons.radio_button_off, color: AppColor.grayWhite),
          ],
        ),
      ),
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
              context.pushNamedAndRemoveUntil(LoginScreen.routeName);
            },
            confirmBackgroundColor: AppColor.primary,
            cancelBackgroundColor: AppColor.grayCard,
            cancelHaveBorder: false,
            iconPath: ImagePng.logo,
          ),
    );
  }
}
