import 'dart:math';

import 'package:blogsphere/Custom_Widget/Animated_Text/extensions/animation_playback_mode.dart';
import 'package:blogsphere/Custom_Widget/Animated_Text/utils/text_transformation.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../dto/dto.dart';
import '../enums/animation_type.dart';
import '../enums/text_alignment.dart';
import '../utils/custom_curved_animation.dart';
import '../utils/interval_step_by_overlap_factor.dart';
import '../utils/spring_curve.dart';
import '../utils/total_duration.dart';
import '../utils/wrap_alignment_by_text_align.dart';


class SpringText extends StatefulWidget {
  final TextStyle? textStyle;
  final String text;
  final double overlapFactor;
  final TextAlignment textAlignment;
  final AnimationMode mode;
  final AnimationType type;
  final Duration duration;
  const SpringText({
    required this.text,
    this.textStyle,
    this.mode = AnimationMode.forward,
    this.overlapFactor = kOverlapFactor,
    this.textAlignment = TextAlignment.start,
    this.type = AnimationType.word,
    this.duration = const Duration(milliseconds: 200),
    super.key,
  });

  @override
  SpringTextState createState() => SpringTextState();
}

class SpringTextState extends State<SpringText> with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _rotations;
  late final List<EffectDto> _data;
  late List<Animation<double>> _opacities;
  late List<Animation<double>> _springAnimations; // To store spring animations

  @override
  void initState() {
    super.initState();
    _data = switch (widget.type) {
      AnimationType.letter => widget.text.splittedLetters,
      _ => widget.text.splittedWords,
    };
    final wordCount = _data.length;

    // Define an overlap factor: this is how much each animation overlaps with the previous one.
    final double overlapFactor = widget.overlapFactor;

    final double intervalStep =
        intervalStepByOverlapFactor(wordCount, overlapFactor);
    final int totalDuration = getTotalDuration(
      wordCount: wordCount,
      duration: widget.duration,
      overlapFactor: widget.overlapFactor,
    );

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: totalDuration),
      reverseDuration: Duration(milliseconds: totalDuration),
    );

    // Create opacity animations with staggered starts (50% overlap)
    _opacities = _data.map((data) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        curvedAnimation(
          _controller,
          data.index,
          intervalStep,
          overlapFactor,
        ),
      );
    }).toList();

    // Create rotation animations with the same staggered starts
    _rotations = _data
        .map(
          (data) => Tween<double>(
            begin: 180.0,
            end: 0.0,
          ).animate(
            curvedAnimation(
              _controller,
              data.index,
              intervalStep,
              overlapFactor,
            ),
          ),
        )
        .toList();

    //  Add spring animation for each word
    _springAnimations = _data.map(
      (data) {
        return Tween<double>(begin: 1, end: 0).animate(
          curvedAnimation(
            _controller,
            data.index,
            intervalStep,
            overlapFactor,
            curve: SpringCurve(),
          ),
        );
      },
    ).toList();

    _controller.animationByMode(widget.mode);
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
        alignment: Alignment.bottomCenter,
        transform: Matrix4.identity()
          // Apply the spring animation for translation
          ..translate(0.0, _springAnimations[data.index].value)
          // Apply rotation
          ..rotateZ(_rotations[data.index].value * pi / 180),
        child: child,
      ),
    );
  }
}
