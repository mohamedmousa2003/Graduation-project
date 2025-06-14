import 'package:final_project_bfcai/core/extensions/context_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/enums/typ_click_auth.dart';
import '../../../../core/helper/observer.dart';
import '../../../../core/providers/animation_provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_style.dart';
import '../../../../core/utils/const.dart';
import '../../../../model/RequestSignUpModel.dart';
import '../../../../model/api_manager.dart';
import '../../../../widget/custom_dialog.dart';
import '../../../../widget/text_form.dart';
import '../../../navigation/presentation/pages/navigation.dart';
import '../../logic/SignUpResponse.dart';
import '../widget/haveornotaccount.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  const RegisterScreen({super.key, this.typClickAuth});

  final TypClickAuth? typClickAuth;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin, RouteAware {
  late AnimationManager _animationManager;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void didPopNext() {
    _animationManager.restartAnimation();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final fullName = _fullNameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final confiremPassword = _confirmPasswordController.text.trim();

      // TODO: Register logic
      print('Registering: $fullName, $email, $password');
      _signUp();
    }
  }




  Future<void> _signUp() async {
    RequestSignUpModel user = RequestSignUpModel(
      name: _fullNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      rePassword: _confirmPasswordController.text,
    );

    SignUpResponse response = await signUpUser(user);

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
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        centerTitle: true,
        elevation: 0,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SlideTransition(
                  position: _animationManager.sliderAnimationLeft,
                  child: Text(welcomeRegisterBack, style: AppTextStyle.size24)),
              Gap(8.h),
              SlideTransition(
                position: _animationManager.sliderAnimationRight,
                child: Text(
                  desWelcomeRegisterBack,
                  style: AppTextStyle.size14.copyWith(color: AppColor.black),
                ),
              ),
              Gap(40.h),

              /// Full Name
              SlideTransition(
                position: _animationManager.sliderAnimationLeft,
                child: TextFormFieldWidget(
                  hintText: enterYourFullName,
                  title: fullName,
                  controller: _fullNameController,
                  myValidator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Full name is required';
                    }
                    return null;
                  },
                ),
              ),
              Gap(12.h),

              /// Email
              SlideTransition(
                position: _animationManager.sliderAnimationRight,
                child: TextFormFieldWidget(
                  hintText: enterYourEmail,
                  title: email,
                  controller: _emailController,
                  myValidator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(text)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              Gap(12.h),

              /// Password
              SlideTransition(
                position: _animationManager.sliderAnimationLeft,
                child: TextFormFieldWidget(
                  hintText: " * * * * * * * *",
                  isPassword: true,
                  obscureText: true,
                  title: password,
                  controller: _passwordController,
                  myValidator: (text) {
                    if (text == null || text.trim().isEmpty) {
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

              /// Confirm Password
              SlideTransition(
                position: _animationManager.sliderAnimationRight,
                child: TextFormFieldWidget(
                  hintText: " * * * * * * * *",
                  isPassword: true,
                  obscureText: true,
                  title: confirmPassword,
                  controller: _confirmPasswordController,
                  myValidator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Confirm password is required';
                    }
                    if (text != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ),
              Gap(40.h),

              /// Register Button
              SlideTransition(
                position: _animationManager.sliderAnimationLeft,
                child: MaterialButtonWidget(
                  onPressed: _submitForm,
                  title: Text(register),
                ),
              ),
              Gap(30.h),

              /// Have account
              SlideTransition(
                position: _animationManager.sliderAnimationBottom,
                child: HaveOrNotAccount(
                  question: haveAccount,
                  navigateTo: login,
                  onTap: () {
                    context.pushNamedAndRemoveUntil(LoginScreen.routeName);
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
