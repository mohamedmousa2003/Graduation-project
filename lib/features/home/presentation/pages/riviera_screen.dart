import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/constant/icons_assets.dart';
import '../../../../core/constant/images_assets.dart';
import '../../../../core/helper/observer.dart';
import '../../../../core/providers/animation_provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/const.dart';
import '../../../../widget/custom_location.dart';
import '../widgets/custom_rating.dart';

class RivieraScreen extends StatefulWidget {
  static const String routeName= "riviera";
  const RivieraScreen({super.key});

  @override
  State<RivieraScreen> createState() => _RivieraScreenState();
}

class _RivieraScreenState extends State<RivieraScreen> with TickerProviderStateMixin, RouteAware {
  late AnimationManager _animationManager;

  @override
  void initState() {
    super.initState();
    _animationManager = AnimationManager();
    _animationManager.initialize(this, const Duration(seconds: 1));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppNavigatorObserver.instance.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    AppNavigatorObserver.instance.unsubscribe(this);
    _animationManager.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    _animationManager.restartAnimation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        centerTitle: true,
        actions: [
          SvgPicture.asset(
            IconsSvg.heart,//heartSelect
            width: 30.w,
            height: 25.h,
            color: AppColor.red,
          ),
          Gap(12.w)
        ],
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColor.primary, size: 30),
        titleTextStyle: AppTextStyle.size21.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            Gap(10.h),
            SlideTransition(
              position: _animationManager.sliderAnimationLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.asset(
                  ImagePng.shimmerTwo,
                  width: double.infinity,
                  height: 160.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Gap(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LocationRow(location: "Hurghada",sizeNum: 30,textNum: 22,),
                    RatingRow(rating: 3.5,sizeNum: 35,sizeText: 25,),
                  ],
                ),
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
                        '120',
                        style: AppTextStyle.size18.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(18.h),
            Text(
              "The Pyramids are some of the most iconic and enduring structures in human history, symbolizing the ingenuity, ambition, and cultural achievements of ancient civilizations. The most famous pyramids are those in Egypt, particularly the Great Pyramid of Giza, but pyramids were also built in other parts of the world, such as Mesoamerica and Sudan.",
              style: AppTextStyle.size16.copyWith(
                height: 1.5,
              ),
              textAlign: TextAlign.start,
              softWrap: true,
            )
          ],
        ),
      ),
    );
  }
}



