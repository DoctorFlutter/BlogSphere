import 'package:blogsphere/Custom_Widget/Animated_Text/enums/slide_animation_type.dart';
import 'package:flutter/material.dart';

Tween<Offset> offsetTweenBySlideType(
  SlideAnimationType type, {
  int index = 0,
}) =>
    switch (type) {
      SlideAnimationType.topBottom => Tween<Offset>(
          begin: const Offset(0, -100),
          end: const Offset(0, 0),
        ),
      SlideAnimationType.bottomTop => Tween<Offset>(
          begin: const Offset(0, 100),
          end: const Offset(0, 0),
        ),
      SlideAnimationType.alternateTB => Tween<Offset>(
          begin: index % 2 == 0 ? const Offset(0, -100) : const Offset(0, 100),
          end: const Offset(0, 0),
        ),
      SlideAnimationType.leftRight => Tween<Offset>(
          begin: const Offset(-100, 0),
          end: const Offset(0, 0),
        ),
      SlideAnimationType.rightLeft => Tween<Offset>(
          begin: const Offset(100, 0),
          end: const Offset(0, 0),
        ),
      SlideAnimationType.alternateLR => Tween<Offset>(
          begin: index % 2 == 0 ? const Offset(-100, 0) : const Offset(100, 0),
          end: const Offset(0, 0),
        ),
    };
