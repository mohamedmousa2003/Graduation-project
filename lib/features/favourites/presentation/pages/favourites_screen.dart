import 'package:flutter/material.dart';

import '../../../../core/constant/images_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/const.dart';
import '../../../../model/TouristPlace.dart';
import '../../../../model/api_manager.dart';
import '../../../../widget/empty.dart';

class FavouritesScreen extends StatelessWidget {
  static const String routeName = 'favourites';
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
      backgroundColor: AppColor.white,
      centerTitle: true,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColor.primary, size: 30),
      titleTextStyle: AppTextStyle.size21.copyWith(
        fontWeight: FontWeight.bold,
      ),
    ),
      body: EmptyStateWidget(
        imagePath: ImagePng.brokenHeart,
        title: favoritesListEmpty,
        description: clickTheHeartIcon,
      )

    );
  }
}

