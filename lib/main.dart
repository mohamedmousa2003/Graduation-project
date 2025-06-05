import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/helper/observer.dart';
import 'core/routes/app_routes.dart';
import 'core/utils/app_colors.dart';
import 'features/splash_screen/splash_screen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "A M U N",
        navigatorObservers: [
          AppNavigatorObserver.instance.routeObserver,
        ],
        color: AppColor.backgroundColor,
        // theme: AppLightTheme.theme,
        // themeMode: ThemeMode.light,
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: AppRoutes.onGenerateRoute,
        home: SplashScreen(),
      ),
    );
  }
}
