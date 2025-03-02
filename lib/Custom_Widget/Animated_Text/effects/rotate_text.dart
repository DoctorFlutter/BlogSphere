import 'dart:math';

import 'package:blogsphere/Custom_Widget/Animated_Text/extensions/animation_playback_mode.dart';
import 'package:blogsphere/Custom_Widget/Animated_Text/utils/text_transformation.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../dto/dto.dart';
import '../enums/animation_type.dart';
import '../enums/rotate_animation_type.dart';
import '../enums/text_alignment.dart';
import '../utils/custom_curved_animation.dart';
import '../utils/double_tween_by_rotate_type.dart';
import '../utils/interval_step_by_overlap_factor.dart';
import '../utils/total_duration.dart';
import '../utils/wrap_alignment_by_text_align.dart';

class RotateText extends StatefulWidget {
  final String text;
  final AnimationType type;
  final AnimationMode mode;
  final double overlapFactor;
  final TextAlignment textAlignment;
  final RotateAnimationType direction;
  final Duration duration;
  final TextStyle? textStyle;

  const RotateText({
    super.key,
    required this.text,
    this.mode = AnimationMode.forward,
    this.overlapFactor = kOverlapFactor,
    this.direction = RotateAnimationType.clockwise,
    this.textAlignment = TextAlignment.start,
    this.textStyle,
    this.type = AnimationType.word,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  RotateTextState createState() => RotateTextState();
}

class RotateTextState extends State<RotateText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _rotates;
  late List<Animation<double>> _opacities;
  late final List<EffectDto> _data;

  @override
  void initState() {
    super.initState();
    _data = switch (widget.type) {
      AnimationType.letter => widget.text.splittedLetters,
      _ => widget.text.splittedWords,
    };

    final wordCount = _data.length;
    final double overlapFactor = widget.overlapFactor;

    final int totalDuration = getTotalDuration(
      wordCount: wordCount,
      duration: widget.duration,
      overlapFactor: overlapFactor,
    );

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: totalDuration),
      reverseDuration: Duration(milliseconds: totalDuration),
    );

    final double intervalStep =
        intervalStepByOverlapFactor(wordCount, overlapFactor);

    // Creating the rotation animations with staggered delays.
    _rotates = _data.map((data) {
      return doubleTweenByRotateType(widget.direction).animate(
        curvedAnimation(
          _controller,
          data.index,
          intervalStep,
          overlapFactor,
        ),
      );
    }).toList();

    _opacities = _data
        .map(
          (data) => Tween<double>(begin: 0.0, end: 1.0).animate(
            curvedAnimation(
              _controller,
              data.index,
              intervalStep,
              overlapFactor,
            ),
          ),
        )
        .toList();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

// Public methods to control the animation
  void playAnimation() {
    _controller.forward();
  }

  void pauseAnimation() {
    _controller.stop();
  }

  void reverseAnimation() {
    _controller.reverse();
  }

  void restartAnimation() {
    _controller.reset();
    Future.delayed(const Duration(milliseconds: 10), () {
      _controller.animationByMode(widget.mode);
    });
  }

  void repeatAnimation({bool reverse = false}) {
    _controller.repeat(reverse: reverse);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: wrapAlignmentByTextAlign(widget.textAlignment),
      children: _data
          .map(
            (dto) => AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return _animatedBuilder(dto, child);
              },
              child: Text(
                dto.text,
                style: widget.textStyle,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _animatedBuilder(EffectDto data, Widget? child) {
    return Opacity(
      opacity: _opacities[data.index].value,
      child: Transform(
        transform: Matrix4.identity()
          ..rotateZ(_rotates[data.index].value * pi / 180), // 3D rotation
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
