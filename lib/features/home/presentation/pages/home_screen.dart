import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_project_bfcai/core/extensions/context_extention.dart';
import 'package:final_project_bfcai/features/home/presentation/pages/riviera_screen.dart';
import 'package:final_project_bfcai/model/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/constant/images_assets.dart';
import '../../../../core/constant/shared_pref.dart';
import '../../../../core/helper/observer.dart';
import '../../../../core/providers/animation_provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../model/ClassicalPlace.dart';
import '../../../../model/HotelsModel.dart';
import '../../../../model/TouristPlace.dart';
import '../../../../widget/logo.dart';
import '../../../chatbot/presentation/pages/chatbot_screen.dart';
import '../../../../widget/custom_location.dart';
import '../../../hotels/hotel/data/models/hotel_model.dart';
import '../../../hotels/pages/hotel_Screen.dart';
import '../../../profile_screen/presentation/widget/design_image.dart';
import '../../classical_place/data/models/classical_place.dart';
import '../../tourist_place/data/models/tourist_place.dart';
import '../widgets/check_login.dart';
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
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40.r,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: DesignImage(
                              width: 80.w,
                              height: 80.h,
                            ),
                          ),
                        ),
                        Gap(12.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              SharedPrefsService.getString("name")??"name",
                              style: AppTextStyle.size21.copyWith(
                                color: AppColor.grayWhite,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              SharedPrefsService.getString("email")??"email",
                              style: AppTextStyle.size16.copyWith(
                                color: AppColor.grayWhite,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Gap(5.w),
                    Spacer(),
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
                    return Skeletonizer(
                      child: SizedBox(
                        height: 210.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            final item = TouristPlace(
                              address: "address",
                              imageUrl: "https://media-cdn.tripadvisor.com/media/photo-o/03/39/9e/3f/citadel-al-qalaa.jpg",
                              cost: 4,
                              description: "data",
                              name: "data name",
                              rating: 4.5,
                              type: "type",
                            );
                            return _buildPlaceItem(context, item);
                          },
                          separatorBuilder: (context, index) => Gap(10.w),
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('An error occurred: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data'));
                  }

                  final touristsList = snapshot.data!;
                  return SizedBox(
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
                                builder: (_) => RivieraScreen(place: item),
                              ),
                            );
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
                      separatorBuilder: (context, index) => Gap(10.w),
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
                              onTap: (){},
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


            Text("Hotels",style: AppTextStyle.size21.copyWith(fontWeight: FontWeight.bold),),
              FutureBuilder<List<HotelModel>>(
            future: ApiManager.getHotels(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No hotels found'));
              }

              final hotels = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
                  height: 60,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: hotels.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final hotel = hotels[index];
                      return  GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HotelCard(hotel: hotel),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              hotel.name,
                              style:AppTextStyle.size18.copyWith(
                                  fontWeight: FontWeight.bold,
                              color: AppColor.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
    ),
  ]
      ),
    )));
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



class PlaceholderCard extends StatelessWidget {
  const PlaceholderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.21,
            color: Colors.grey.shade400,
          ),
          Gap(8.h),
          Container(height: 14.h, width: 120.w, color: Colors.grey.shade400),
          Gap(6.h),
          Container(height: 14.h, width: 80.w, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}


Widget _buildPlaceItem(BuildContext context, TouristPlace item) {
  return GestureDetector(
    onTap: () {
      handleAuthNavigation(
        context: context,
        destinationBuilder: (_) => RivieraScreen(place: item),
      );

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
            item.imageUrl ?? "",
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.21,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
          ),
          Gap(8.h),
          LocationRow(location: item.name ?? ""),
          RatingRow(
            rating: item.rating != null
                ? double.tryParse(item.rating.toString()) ?? 0.0
                : 0.0,
          ),
        ],
      ),
    ),
  );
}

