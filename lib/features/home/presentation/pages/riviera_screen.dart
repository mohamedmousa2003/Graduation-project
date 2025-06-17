// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:gap/gap.dart';
//
// import '../../../../core/constant/icons_assets.dart';
// import '../../../../core/constant/images_assets.dart';
// import '../../../../core/helper/observer.dart';
// import '../../../../core/providers/animation_provider.dart';
// import '../../../../core/utils/app_colors.dart';
// import '../../../../core/utils/app_text_style.dart';
// import '../../../../core/utils/const.dart';
// import '../../../../model/TouristPlace.dart';
// import '../../../../widget/custom_location.dart';
// import '../widgets/custom_rating.dart';
//
// class RivieraScreen extends StatefulWidget {
//   static const String routeName= "riviera";
//   final TouristPlace place;
//   const RivieraScreen({super.key,required this.place});
//
//   @override
//   State<RivieraScreen> createState() => _RivieraScreenState();
// }
//
// class _RivieraScreenState extends State<RivieraScreen> with TickerProviderStateMixin, RouteAware {
//   late AnimationManager _animationManager;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationManager = AnimationManager();
//     _animationManager.initialize(this, const Duration(seconds: 1));
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     AppNavigatorObserver.instance.subscribe(this, ModalRoute.of(context)!);
//   }
//
//   @override
//   void dispose() {
//     AppNavigatorObserver.instance.unsubscribe(this);
//     _animationManager.dispose();
//     super.dispose();
//   }
//
//   @override
//   void didPopNext() {
//     _animationManager.restartAnimation();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.backgroundColor,
//       appBar: AppBar(
//         backgroundColor: AppColor.backgroundColor,
//         centerTitle: true,
//         actions: [
//           SvgPicture.asset(
//             IconsSvg.heart,//heartSelect
//             width: 30.w,
//             height: 25.h,
//             color: AppColor.red,
//           ),
//           Gap(12.w)
//         ],
//         elevation: 0,
//         iconTheme: const IconThemeData(color: AppColor.primary, size: 30),
//         titleTextStyle: AppTextStyle.size21.copyWith(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       body:SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 10.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.network(
//               place.imageUrl ?? '',
//               width: double.infinity,
//               height: 220.h,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
//             ),
//             Gap(8.h),
//             LocationRow(location: place.address ?? ""),
//             Gap(5.h),
//             RatingRow(rating: place.rating != null ? double.tryParse(place.rating.toString()) ?? 0.0 : 0.0,),
//             Gap(5.h),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
//               decoration: BoxDecoration(
//                 color: Colors.orange,
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'EGY',
//                     style: AppTextStyle.size18.copyWith(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(width: 8.w),
//                   Text(
//                     place.cost.toString() ,
//                     style: AppTextStyle.size18.copyWith(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Gap(5.h),
//
//             Text(place.type ?? "",style: AppTextStyle.size18.copyWith(
//               fontWeight: FontWeight.bold,
//             ),
//             ),
//             Gap(8.h),
//             Text(place.description ?? "",style: AppTextStyle.size16.copyWith(
//               height: 1.5,
//             ),
//               textAlign: TextAlign.start,
//               softWrap: true,),
//             const SizedBox(height: 8),
//             MyGoogleMapLink(text: place.name?? "",),
//             const SizedBox(height: 8),
//             MyGoogleLink(text: place.name?? "",),
//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// /*
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:gap/gap.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../core/constant/icons_assets.dart';
// import '../../../../core/constant/images_assets.dart';
// import '../../../../core/helper/observer.dart';
// import '../../../../core/providers/animation_provider.dart';
// import '../../../../core/utils/app_colors.dart';
// import '../../../../core/utils/app_text_style.dart';
// import '../../../../core/utils/const.dart';
// import '../../../../model/TouristPlace.dart';
// import '../../../../provider/my_provider.dart';
// import '../../../../test.dart';
// import '../../../../widget/custom_location.dart';
// import '../widgets/custom_rating.dart';
//
// class RivieraScreen extends StatefulWidget {
//   static const String routeName= "riviera";
//   final TouristPlace place;
//
//   const RivieraScreen({super.key,required this.place});
//
//   @override
//   State<RivieraScreen> createState() => _RivieraScreenState();
// }
//
// class _RivieraScreenState extends State<RivieraScreen> with TickerProviderStateMixin, RouteAware {
//   late AnimationManager _animationManager;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationManager = AnimationManager();
//     _animationManager.initialize(this, const Duration(seconds: 1));
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     AppNavigatorObserver.instance.subscribe(this, ModalRoute.of(context)!);
//   }
//
//   @override
//   void dispose() {
//     AppNavigatorObserver.instance.unsubscribe(this);
//     _animationManager.dispose();
//     super.dispose();
//   }
//
//   @override
//   void didPopNext() {
//     _animationManager.restartAnimation();
//   }
//   @override
//   Widget build(BuildContext context) {
//     final favoritesProvider = context.watch<FavoritesProvider>();
//     final isFavorite = favoritesProvider.isFavorite(widget.place); // استخدم place مباشرة هنا
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.place.name ?? '', style: AppTextStyle.size24),
//         actions: [
//           IconButton(
//             icon: Icon(
//               isFavorite ? Icons.favorite : Icons.favorite_border,
//               color: isFavorite ? Colors.red : Colors.grey,
//             ),
//             onPressed: () {
//               favoritesProvider.toggleFavorite(widget.place);
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 10.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.network(
//               widget.place.imageUrl ?? '',
//               width: double.infinity,
//               height: 220.h,
//               fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
//             ),
//             Gap(8.h),
//             LocationRow(location:  widget.place.address ?? ""),
//             Gap(5.h),
//             RatingRow(rating:  widget.place.rating != null ? double.tryParse( widget.place.rating.toString()) ?? 0.0 : 0.0,),
//             Gap(5.h),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
//               decoration: BoxDecoration(
//                 color: Colors.orange,
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     'EGY',
//                     style: AppTextStyle.size18.copyWith(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(width: 8.w),
//                   Text(
//                     widget.place.cost.toString() ,
//                     style: AppTextStyle.size18.copyWith(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Gap(5.h),
//
//             Text( widget.place.type ?? "",style: AppTextStyle.size18.copyWith(
//               fontWeight: FontWeight.bold,
//             ),
//             ),
//             Gap(8.h),
//             Text( widget.place.description ?? "",style: AppTextStyle.size16.copyWith(
//               height: 1.5,
//             ),
//               textAlign: TextAlign.start,
//               softWrap: true,),
//             const SizedBox(height: 8),
//             MyGoogleMapLink(text:  widget.place.name?? "",),
//             const SizedBox(height: 8),
//             MyGoogleLink(text:  widget.place.name?? "",),
//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
//  */

import 'package:final_project_bfcai/model/ClassicalPlace.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../model/TouristPlace.dart';
import '../../../../provider/my_provider.dart';
import '../../../../test.dart';
import '../../../../widget/custom_location.dart';
import '../widgets/custom_rating.dart';
class RivieraScreen extends StatelessWidget {
  final TouristPlace place;
  const RivieraScreen ({super.key,required this.place});

  @override
  Widget build(BuildContext context) {
    // var favoritesProvider1 = Provider.of<FavoritesProvider>(context);
    // final isFavorite = favoritesProvider1.isFavorite(place as ClassicalPlace);
    return Scaffold(
      appBar: AppBar(
        actions: [
          // IconButton(
          //   icon: Icon(
          //     isFavorite ? Icons.favorite : Icons.favorite_border,
          //     color: isFavorite ? Colors.red : Colors.grey,
          //   ),
          //   onPressed: () {
          //     favoritesProvider1.toggleFavorite(place as ClassicalPlace);
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(
          //         content: Text('${place.name} removed from favorites'),
          //         duration: Duration(seconds: 1),
          //         behavior: SnackBarBehavior.floating,
          //         backgroundColor: AppColor.green,
          //         margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: MediaQuery.of(context).size.height / 2.5),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(16.r),
          //         ),
          //       ),
          //     );
          //   },
          // ),

        ],
        title: Text(place.name ?? '',style: AppTextStyle.size24,),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              place.imageUrl ?? '',
              width: double.infinity,
              height: 220.h,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
            ),
            Gap(8.h),
            LocationRow(location: place.address ?? ""),
            Gap(5.h),
            RatingRow(rating: place.rating != null ? double.tryParse(place.rating.toString()) ?? 0.0 : 0.0,),
            Gap(5.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'EGY',
                    style: AppTextStyle.size18.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    place.cost.toString() ,
                    style: AppTextStyle.size18.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Gap(5.h),

            Text(place.type ?? "",style: AppTextStyle.size18.copyWith(
              fontWeight: FontWeight.bold,
            ),
            ),
            Gap(8.h),
            Text(place.description ?? "",style: AppTextStyle.size16.copyWith(
              height: 1.5,
            ),
              textAlign: TextAlign.start,
              softWrap: true,),
            const SizedBox(height: 8),
            MyGoogleMapLink(text: place.name?? "",),
            const SizedBox(height: 8),
            MyGoogleLink(text: place.name?? "",),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
