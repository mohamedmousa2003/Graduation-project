import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../provider/my_provider.dart';
import '../../../../widget/empty.dart';
import '../../../../core/constant/images_assets.dart';
import '../../../../core/utils/const.dart';
import '../../../../model/ClassicalPlace.dart';
import '../../../home/classical_place/data/models/classical_place.dart';
import '../../../home/presentation/pages/classical_screen.dart';

class FavouritesScreen extends StatelessWidget {
  static const String routeName = 'favourites';

  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = context.watch<FavoritesProvider>();
    final favoritePlaces = favoritesProvider.favorites;

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColor.primary, size: 30),
        title: Text(
          'Favorites',
          style: AppTextStyle.size21.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: favoritePlaces.isEmpty
          ? EmptyStateWidget(
        imagePath: ImagePng.brokenHeart,
        title: favoritesListEmpty,
        description: clickTheHeartIcon,
      )
          : ListView.builder(
        itemCount: favoritePlaces.length,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        itemBuilder: (context, index) {
          final place = favoritePlaces[index];

          return GestureDetector(
            onTap: () {
              // اختبر النوع واذهب للشاشة المناسبة
              if (place is ClassicalPlace) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        ClassicalDetailScreen(place: place),
                  ),
                );
              } else {
                // add TouristDetailScreen if you have one
              }
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                    child: Image.network(
                      place.imageUrl ?? '',
                      width: double.infinity,
                      height: 180.h,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                place.name ??'',
                                style: AppTextStyle.size18.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                place.type ?? '',
                                style: AppTextStyle.size14.copyWith(
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_forever,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            favoritesProvider.toggleFavorite(place);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${place.name} removed from favorites',
                                ),
                                duration: Duration(seconds: 1),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: AppColor.red,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 40.w,
                                  vertical: MediaQuery.of(context)
                                      .size
                                      .height /
                                      2.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(16.r),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
