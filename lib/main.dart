import 'package:final_project_bfcai/provider/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/constant/shared_pref.dart';
import 'core/helper/observer.dart';
import 'core/routes/app_routes.dart';
import 'core/utils/app_colors.dart';
import 'features/splash_screen/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsService.init(); // Initialize before app starts
  runApp(

    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: MyApp(),
    ),
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
