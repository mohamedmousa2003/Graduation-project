import 'dart:developer';
import 'package:final_project_bfcai/core/extensions/context_extention.dart';
import 'package:final_project_bfcai/features/auth/presentation/pages/register_screen.dart';
import 'package:final_project_bfcai/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/constant/icons_assets.dart';
import '../../../../core/constant/shared_pref.dart';
import '../../../../core/enums/typ_click_auth.dart';
import '../../../../core/helper/observer.dart';
import '../../../../core/providers/animation_provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/const.dart';
import '../../../../model/api_manager.dart';
import '../../../../widget/custom_dialog.dart';
import '../../../../widget/text_form.dart';
import '../../../navigation/presentation/pages/navigation.dart';
import '../../logic/sign_up_response.dart';
import '../widget/haveornotaccount.dart';
import 'forgetpassword.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  const LoginScreen({super.key, this.typClickAuth});

  final TypClickAuth? typClickAuth;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin, RouteAware {
  late AnimationManager _animationManager;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationManager = AnimationManager();
    _animationManager.initialize(this, const Duration(milliseconds: 600));
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    _animationManager.restartAnimation();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      // TODO: Use email & password for login logic
      log("Login pressed with email: $email and password: $password");
      _signIn();
    }
  }




  Future<void> _signIn() async {
    SignInModelRequest user = SignInModelRequest(
      email: _emailController.text,
      password: _passwordController.text,
    );

    SignUpResponse response = await signInUser(user);
    SharedPrefsService.saveString("name", response.user!.name!);
    SharedPrefsService.saveString("email", response.user!.email!);
    print(response.message);
    if (response.success == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Success"),

          backgroundColor: AppColor.primary,
        ),
      );
      Navigator.of(context).pushReplacementNamed(MainControllerScreens.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message.toString()),
          backgroundColor: AppColor.red,
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    log(widget.typClickAuth.toString());
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: AppColor.primary, size: 30),
        titleTextStyle: AppTextStyle.size21.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SlideTransition(
                position: _animationManager.sliderAnimationLeft,
                child: Row(
                  children: [
                    Text(welcomeLoginBack, style: AppTextStyle.size24),
                    Gap(8.w),
                    Image.asset(
                      IconsPng.welcomeBack,
                      width: 30.w,
                      height: 30.h,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              Gap(8.h),
              SlideTransition(
                position: _animationManager.sliderAnimationRight,
                child: Text(
                  desWelcomeBack,
                  style: AppTextStyle.size14.copyWith(color: AppColor.black),
                ),
              ),
              Gap(40.h),

              /// Email Field
              SlideTransition(
                position: _animationManager.sliderAnimationLeft,
                child: TextFormFieldWidget(
                  hintText: enterYourEmail,
                  title: email,
                  controller: _emailController,
                  myValidator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Email is required';
                    }
                    // if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                    //     .hasMatch(text)) {
                    //   return 'Enter a valid email address';
                    // }
                    return null;
                  },
                ),
              ),
              Gap(20.h),

              /// Password Field
              SlideTransition(
                position: _animationManager.sliderAnimationRight,
                child: TextFormFieldWidget(
                  hintText: " * * * * * * * *",
                  isPassword: true,
                  obscureText: true,
                  title: password,
                  controller: _passwordController,
                  myValidator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Password is required';
                    }
                    if (text.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
              ),
              Gap(12.h),

              /// Forgot password
              SlideTransition(
                position: _animationManager.sliderAnimationLeft,
                child: GestureDetector(
                  onTap: () {
                    context.pushNamed(ForgetPasswordScreen.routeName);
                  },
                  child: Text(
                    textAlign: TextAlign.right,
                    forgotPassword,
                    style: AppTextStyle.size14.copyWith(
                      color: AppColor.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColor.primary,
                    ),
                  ),
                ),
              ),
              Gap(40.h),

              /// Login Button
              SlideTransition(
                position: _animationManager.sliderAnimationRight,
                child: MaterialButtonWidget(
                  onPressed: _submitForm,
                  title: Text(login),
                ),
              ),
              Gap(30.h),

              /// Register Navigation
              SlideTransition(
                position: _animationManager.sliderAnimationBottom,
                child: HaveOrNotAccount(
                  question: noHaveAccount,
                  navigateTo: register,
                  onTap: () {
                    context.pushNamedAndRemoveUntil(RegisterScreen.routeName);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
