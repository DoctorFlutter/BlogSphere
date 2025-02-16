import 'package:blogsphere/Custom_Widget/Animated_Text/enums/rotate_animation_type.dart';
import 'package:flutter/material.dart';

Tween<double> doubleTweenByRotateType(RotateAnimationType direction) =>
    switch (direction) {
      RotateAnimationType.clockwise => Tween<double>(begin: 0.0, end: 360.0),
      RotateAnimationType.anticlockwise =>
        Tween<double>(begin: 360.0, end: 0.0),
    };
