import '../../../../core/constant/icons_assets.dart';
import 'onboarding_info.dart';

class OnboardingItems {
  List<OnboardingInfo> items = [
    // screen one
    OnboardingInfo(
      image: IconsSvg.onboarding1,
      title: "Manage your journey",
      description:
          "Pack your bags! Your tourism adventure starts here with our new project.",
    ),
    //screen two
    OnboardingInfo(
      image: IconsSvg.onboarding2,
      title: "Discover the tourist attractions",
      description:
          "Discover with us new opportunities to enjoy our rich heritage and stunning natural beauty.",
    ),
    //screen three
    OnboardingInfo(
      image: IconsSvg.onboarding3,
      title: "Golden sand",
      description:
          "Welcome to our tourism project! Set off to explore the most beautiful beaches and enjoy the most wonderful moments.",
    ),
  ];
}
