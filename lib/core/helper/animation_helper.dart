import 'package:flutter/widgets.dart';

enum SlideDirection { fromTop, fromBottom, fromLeft, fromRight }

class AnimationHelper {
  static Animation<Offset> createSlideAnimation({
    required AnimationController controller,
    required SlideDirection direction,
  }) {
    late Offset begin;
    switch (direction) {
      case SlideDirection.fromTop:
        begin = const Offset(0, -1); // من الأعلى
        break;
      case SlideDirection.fromBottom:
        begin = const Offset(0, 1); // من الأسفل
        break;
      case SlideDirection.fromLeft:
        begin = const Offset(-1, 0); // من اليسار
        break;
      case SlideDirection.fromRight:
        begin = const Offset(1, 0); // من اليمين
        break;
    }

    return Tween<Offset>(
      begin: begin,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    ));
  }
}
