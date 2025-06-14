import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/congrats_screen.dart';
import '../../features/auth/presentation/pages/forget_pass_create_new_password_screen.dart';
import '../../features/auth/presentation/pages/forget_pass_verify_code_screen.dart';
import '../../features/auth/presentation/pages/forgetpassword.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/register_screen.dart';
import '../../features/auth/presentation/pages/select_auth.dart';
import '../../features/chatbot/presentation/pages/chatbot_screen.dart';
import '../../features/favourites/presentation/pages/favourites_screen.dart';
import '../../features/home/presentation/pages/classical_screen.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/home/presentation/pages/riviera_screen.dart';
import '../../features/navigation/presentation/pages/navigation.dart';
import '../../features/onboarding/presentation/pages/onboarding_view.dart';
import '../../features/profile_screen/presentation/pages/profile_screen.dart';
import '../../features/profile_screen/presentation/pages/profile_setting.dart';
import '../../features/search/presentation/pages/search_Screen.dart';
import '../../features/splash_screen/splash_screen.dart';
import '../../features/trip/presentation/pages/plan_trip_screen.dart';
import '../../features/trip/presentation/pages/trip_model.dart';
import '../enums/typ_click_auth.dart';
import 'animation_routes.dart';

class AppRoutes {
  static Route<void> onGenerateRoute(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      // case ChooseLanguage.routeName:
      //   return AnimationRoute(page: const ChooseLanguage());
      case OnboardingView.routeName:
        return AnimationRoute(page: const OnboardingView());
      case SelectAuth.routeName:
        return AnimationRoute(page: const SelectAuth());
      case LoginScreen.routeName:
        return AnimationRoute(
          page: LoginScreen(
            typClickAuth: arg is TypClickAuth ? arg : TypClickAuth.login,
          ),
        );
      case RegisterScreen.routeName:
        return AnimationRoute(
          page: RegisterScreen(
            typClickAuth: arg is TypClickAuth ? arg : TypClickAuth.register,
          ),
        );

      // case VerificationCodeScreen.routeName:
      //   return AnimationRoute(page: const VerificationCodeScreen());
      case ForgetPasswordScreen.routeName:
        return AnimationRoute(page: const ForgetPasswordScreen());
      case ForgetPassVerifyCode.routeName:
        return AnimationRoute(page: const ForgetPassVerifyCode());
      case ForgetPassCreateNewPasswordScreen.routeName:
        return AnimationRoute(page: const ForgetPassCreateNewPasswordScreen());
      case CongratsScreen.routeName:
        return AnimationRoute(page: const CongratsScreen());
      case SplashScreen.routeName:
        return AnimationRoute(page: const SplashScreen());
      case HomeScreen.routeName:
        return AnimationRoute(page: const HomeScreen());
      case MainControllerScreens.routeName:
        return AnimationRoute(page: const MainControllerScreens());
      case ProfileScreen.routeName:
        return AnimationRoute(page: const ProfileScreen());
      case FavouritesScreen.routeName:
        return AnimationRoute(page: const FavouritesScreen());
      case TripModel.routeName:
        return AnimationRoute(page:  TripModel());
      case ProfileImageSetting.routeName:
        return AnimationRoute(page: const ProfileImageSetting());
      case ChatbotScreen.routeName:
        return AnimationRoute(page: const ChatbotScreen());


      case ClassicalPlacesScreen.routeName:
        return AnimationRoute(page: ClassicalPlacesScreen());
      case PlanTripScreen.routeName:
        return AnimationRoute(page: const PlanTripScreen());
      // case EditProfile.routeName:
      //   return AnimationRoute(page: const EditProfile());
      // case EditNumPhoneProfile.routeName:
      //   return AnimationRoute(page: const EditNumPhoneProfile());
      // case VerificationCodeProfileScreen.routeName:
      //   return AnimationRoute(page: const VerificationCodeProfileScreen());
      // case PreviousOrderScreen.routeName:
      //   return AnimationRoute(page: const PreviousOrderScreen());
      // case FavoriteScreen.routeName:
      //   return AnimationRoute(page:  FavoriteScreen());
      // case RatingScreen.routeName:
      //   return AnimationRoute(page: const RatingScreen());
      // case SavedPostsScreen.routeName:
      //   return AnimationRoute(page: const SavedPostsScreen());
      // case SearchScreen.routeName:
      //   return AnimationRoute(
      //       page: BlocProvider<SearchCubit>(
      //         create: (context) => SearchCubit(),
      //         child: const SearchScreen(),
      //       ));
      default:
        //return AnimationRoute(page: const SplashScreenAnimation());
        return AnimationRoute(page: const SplashScreen());
    }
  }
}
