import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_project_bfcai/core/extensions/context_extention.dart';
import 'package:final_project_bfcai/model/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/constant/images_assets.dart';
import '../../../../core/helper/observer.dart';
import '../../../../core/providers/animation_provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../model/ClassicalPlace.dart';
import '../../../../model/TouristPlace.dart';
import '../../../../widget/logo.dart';
import '../../../chatbot/presentation/pages/chatbot_screen.dart';
import '../../../../widget/custom_location.dart';
import '../../../search/presentation/pages/search_Screen.dart';
import '../widgets/custom_rating.dart';
import '../widgets/image_url_controller_widget.dart';
import 'classical_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin, RouteAware {
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SlideTransition(
                position: _animationManager.sliderAnimationLeft,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap:(){
            context.pushNamed(ClassicalPlacesScreen.routeName);
          },
                      child: Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width * 0.75,
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: AppColor.lightGray,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    Gap(5.w),
                    GestureDetector(
                      onTap: (){
                        context.pushNamed(ChatbotScreen.routeName);
                      },
                        child: Logo()),
                  ],
                ),
              ),
              Gap(20.h),
              _carouselSliderBuilder(),
              Gap(20.h),
              // Text(
              //   classical,
              //   style: AppTextStyle.size21.copyWith(fontWeight: FontWeight.bold),
              // ),
              Gap(5.h),
              FutureBuilder<List<TouristPlace>>(
                future: ApiManager.getTourist(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return  Skeletonizer(
                      child: SizedBox(
                        height: 210.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            final item =TouristPlace(
                              address: "address" ,
                              imageUrl: "https://media-cdn.tripadvisor.com/media/photo-o/03/39/9e/3f/citadel-al-qalaa.jpg" ,
                              cost: 4,
                              description: "data",
                              name: "data name",
                              rating: 4.5,
                              type: "type"
                            );
                            return GestureDetector(
                              onTap: (){
                                //
                              },
                              child: Container(
                                width: 200.w,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Column(
                                  children: [
                                    Image.network(
                                      width: double.infinity,
                                      height: MediaQuery.of(context).size.height*0.21,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                                      item.imageUrl ?? "",
                                    ),
                                    Gap(8.h),
                                    LocationRow(location: item.name ?? ""),
                                    RatingRow(rating: item.rating != null ? double.tryParse(item.rating.toString()) ?? 0.0 : 0.0,),
                                    // Text(
                                    //   item.description ?? "",
                                    //  style: AppTextStyle.size16.copyWith(
                                    //     height: 1.5,
                                    //   ),
                                    //   textAlign: TextAlign.start,
                                    //   softWrap: true,
                                    // ),
                                    // Container(
                                    //   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.orange,
                                    //     borderRadius: BorderRadius.circular(12.r),
                                    //   ),
                                    //   child: Row(
                                    //     mainAxisSize: MainAxisSize.min,
                                    //     children: [
                                    //       Text(
                                    //         'EGY',
                                    //         style: AppTextStyle.size18.copyWith(
                                    //           color: Colors.white,
                                    //           fontWeight: FontWeight.bold,
                                    //         ),
                                    //       ),
                                    //       SizedBox(width: 8.w),
                                    //       Text(
                                    //         item.cost?.toString() ?? "",
                                    //         style: AppTextStyle.size18.copyWith(
                                    //           color: Colors.white,
                                    //           fontWeight: FontWeight.bold,
                                    //         ),
                                    //       )
                                    //     ],
                                    //   ),
                                    // ),
                      
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                      
                            return Gap(10.w);
                          },
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('An error occurred: ${snapshot.error}')
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data'));
                  }

                  final touristsList = snapshot.data!;
                  return  SizedBox(
                    height: 210.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: touristsList.length,
                      itemBuilder: (context, index) {
                        final item = touristsList[index];
                        return GestureDetector(
                          onTap: (){
                            //
                          },
                          child: Container(
                            width: 200.w,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Column(
                              children: [
                                Image.network(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height*0.21,
                                    fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                                    item.imageUrl ?? "",
                                ),
                                Gap(8.h),
                                LocationRow(location: item.name ?? ""),
                                RatingRow(rating: item.rating != null ? double.tryParse(item.rating.toString()) ?? 0.0 : 0.0,),
                                // Text(
                                //   item.description ?? "",
                                //  style: AppTextStyle.size16.copyWith(
                                //     height: 1.5,
                                //   ),
                                //   textAlign: TextAlign.start,
                                //   softWrap: true,
                                // ),
                                // Container(
                                //   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                //   decoration: BoxDecoration(
                                //     color: Colors.orange,
                                //     borderRadius: BorderRadius.circular(12.r),
                                //   ),
                                //   child: Row(
                                //     mainAxisSize: MainAxisSize.min,
                                //     children: [
                                //       Text(
                                //         'EGY',
                                //         style: AppTextStyle.size18.copyWith(
                                //           color: Colors.white,
                                //           fontWeight: FontWeight.bold,
                                //         ),
                                //       ),
                                //       SizedBox(width: 8.w),
                                //       Text(
                                //         item.cost?.toString() ?? "",
                                //         style: AppTextStyle.size18.copyWith(
                                //           color: Colors.white,
                                //           fontWeight: FontWeight.bold,
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),

                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {

                        return Gap(10.w);
                      },
                    ),
                  );
                },
              ),


              Gap(15.h),

              // Text(
              //   riviera,
              //   style: AppTextStyle.size21.copyWith(fontWeight: FontWeight.bold),
              // ),
              Gap(5.h),
              FutureBuilder<List<ClassicalPlace>>(
                future: ApiManager.getClassical(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return  Skeletonizer(
                      child: SizedBox(
                        height: 210.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            final item =TouristPlace(
                                address: "address" ,
                                imageUrl: "https://media-cdn.tripadvisor.com/media/photo-o/03/39/9e/3f/citadel-al-qalaa.jpg" ,
                                cost: 4,
                                description: "data",
                                name: "data name",
                                rating: 4.5,
                                type: "type"
                            );
                            return GestureDetector(
                              onTap: (){
                                //
                              },
                              child: Container(
                                width: 200.w,
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Column(
                                  children: [
                                    Image.network(
                                      width: double.infinity,
                                      height: MediaQuery.of(context).size.height*0.21,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                                      item.imageUrl ?? "",
                                    ),
                                    Gap(8.h),
                                    LocationRow(location: item.name ?? ""),
                                    RatingRow(rating: item.rating != null ? double.tryParse(item.rating.toString()) ?? 0.0 : 0.0,),
                                    // Text(
                                    //   item.description ?? "",
                                    //  style: AppTextStyle.size16.copyWith(
                                    //     height: 1.5,
                                    //   ),
                                    //   textAlign: TextAlign.start,
                                    //   softWrap: true,
                                    // ),
                                    // Container(
                                    //   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.orange,
                                    //     borderRadius: BorderRadius.circular(12.r),
                                    //   ),
                                    //   child: Row(
                                    //     mainAxisSize: MainAxisSize.min,
                                    //     children: [
                                    //       Text(
                                    //         'EGY',
                                    //         style: AppTextStyle.size18.copyWith(
                                    //           color: Colors.white,
                                    //           fontWeight: FontWeight.bold,
                                    //         ),
                                    //       ),
                                    //       SizedBox(width: 8.w),
                                    //       Text(
                                    //         item.cost?.toString() ?? "",
                                    //         style: AppTextStyle.size18.copyWith(
                                    //           color: Colors.white,
                                    //           fontWeight: FontWeight.bold,
                                    //         ),
                                    //       )
                                    //     ],
                                    //   ),
                                    // ),

                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {

                            return Gap(10.w);
                          },
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('An error occurred: ${snapshot.error}')
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data'));
                  }

                  final touristsList = snapshot.data!;
                  return  SizedBox(
                    height: 210.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: touristsList.length,
                      itemBuilder: (context, index) {
                        final item = touristsList[index];
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ClassicalDetailScreen(place: item),
                              ),
                            );
                            //context.pushNamed(ClassicalScreen.routeName);
                          },
                          child: Container(
                            width: 200.w,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: Column(
                              children: [
                                Image.network(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height*0.21,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                                  item.imageUrl ?? "",
                                ),
                                Gap(8.h),
                                LocationRow(location: item.name ?? ""),
                                RatingRow(rating: item.rating != null ? double.tryParse(item.rating.toString()) ?? 0.0 : 0.0,),

                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {

                        return Gap(10.w);
                      },
                    ),
                  );
                },
              ),
              Gap(10.h),

            ],
          ),
        ),
      ),
    );
  }

  Widget _carouselSliderBuilder() {
    List<String> imageList = [
      ImagePng.shimmerOne,
      ImagePng.shimmerTwo,
      ImagePng.shimmerThree,
      ImagePng.shimmerFour,
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          enlargeCenterPage: true,
          pageSnapping: true,
          padEnds: false,
          viewportFraction: 1,
          clipBehavior: Clip.none,
          height: 150.h,
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          scrollDirection: Axis.horizontal,
        ),
        itemCount: imageList.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            ImageUrlControllerWidget(
              width: double.infinity,
              height: double.infinity,
              imageUrl: imageList[itemIndex],
              borderRadius: BorderRadius.circular(2.r),
            ),
      ),
    );
  }
}
