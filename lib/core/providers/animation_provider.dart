import 'package:flutter/material.dart';
import '../helper/animation_helper.dart';

class AnimationManager {
  late AnimationController controller;
  late Animation<Offset> sliderAnimationTop;
  late Animation<Offset> sliderAnimationBottom;
  late Animation<Offset> sliderAnimationLeft;
  late Animation<Offset> sliderAnimationRight;

  bool isInitialized = false;

  void initialize(TickerProvider vsync, Duration duration) {
    controller = AnimationController(
      vsync: vsync,
      duration: duration,
    );

    sliderAnimationTop = AnimationHelper.createSlideAnimation(
      controller: controller,
      direction: SlideDirection.fromTop,
    );

    sliderAnimationBottom = AnimationHelper.createSlideAnimation(
      controller: controller,
      direction: SlideDirection.fromBottom,
    );

    sliderAnimationLeft = AnimationHelper.createSlideAnimation(
      controller: controller,
      direction: SlideDirection.fromLeft,
    );

    sliderAnimationRight = AnimationHelper.createSlideAnimation(
      controller: controller,
      direction: SlideDirection.fromRight,
    );

    controller.forward(); // أول مرة
    isInitialized = true;
  }

  void restartAnimation() {
    if (isInitialized) {
      controller.reset();
      controller.forward();
    }
  }

  void dispose() {
    controller.dispose();
  }
}
