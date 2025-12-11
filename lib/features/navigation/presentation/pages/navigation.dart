import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constant/icons_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../favourites/presentation/pages/favourites_screen.dart';
import '../../../home/presentation/pages/home_screen.dart';
import '../../../profile_screen/presentation/pages/profile_screen.dart';
import '../../../search/presentation/pages/search_Screen.dart';
import '../../../trip/presentation/pages/trip_model.dart';

class MainControllerScreens extends StatefulWidget {
  static const routeName = "main-controller-screen";
  const MainControllerScreens({super.key});

  @override
  State<MainControllerScreens> createState() => _MainControllerScreensState();
}

class _MainControllerScreensState extends State<MainControllerScreens> {
  final List<Widget> _pages =  [
    HomeScreen(),
    TripModel(),
    FavouritesScreen(),
    ClassicalPlacesScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (selectedIndex) {
          _currentIndex = selectedIndex;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            icon: _iconBar(IconsSvg.home),
            activeIcon: _activeIconBar(IconsSvg.homeSelected),
            label: "home",
            backgroundColor:Color(0xFFAAA38A),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplanemode_active,size: 32,color: AppColor.grayWhite,),
            activeIcon: Icon(Icons.airplanemode_active,size: 35,),
            backgroundColor: AppColor.primary,
            label: "trip",

          ),
          BottomNavigationBarItem(
            icon: _iconBar(IconsSvg.heartProfile),
            activeIcon: _activeIconBar(IconsSvg.heartProfile),
            label: "favourite",
            backgroundColor: AppColor.lightGray,
          ),
          BottomNavigationBarItem(
            icon: _iconBar(IconsSvg.search),
            activeIcon: _activeIconBar(IconsSvg.search),
            label: "search",
            backgroundColor: AppColor.lightGray,
          ),
          BottomNavigationBarItem(
            icon: _iconBar(IconsSvg.profile),
            activeIcon: _activeIconBar(IconsSvg.profile),
            label: "profile",
            backgroundColor:AppColor.primary,

          ),

        ],
      ),
    );
  }

  Widget _iconBar(String image) {
    return SvgPicture.asset(
      image,
      height: 24.h,
      width: 24.w,
      color: AppColor.grayWhite,
      // fit: BoxFit.fill,
    );
  }

  Widget _activeIconBar(String image) {
    return SvgPicture.asset(
      image,
      height: 24.h,
      width: 24.w,
      // fit: BoxFit.cover,
      color: AppColor.white,
    );

  }
}
