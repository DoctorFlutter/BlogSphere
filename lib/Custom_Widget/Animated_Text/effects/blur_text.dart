import 'dart:ui';
import 'package:blogsphere/Custom_Widget/Animated_Text/constants/constants.dart';
import 'package:blogsphere/Custom_Widget/Animated_Text/dto/dto.dart';
import 'package:blogsphere/Custom_Widget/Animated_Text/enums/animation_type.dart';
import 'package:blogsphere/Custom_Widget/Animated_Text/enums/text_alignment.dart';
import 'package:blogsphere/Custom_Widget/Animated_Text/extensions/animation_playback_mode.dart';
import 'package:blogsphere/Custom_Widget/Animated_Text/utils/custom_curved_animation.dart';
import 'package:blogsphere/Custom_Widget/Animated_Text/utils/text_align_by_text_alignment.dart';
import 'package:blogsphere/Custom_Widget/Animated_Text/utils/text_transformation.dart';
import 'package:blogsphere/Custom_Widget/Animated_Text/utils/total_duration.dart';
import 'package:flutter/material.dart';

import '../utils/interval_step_by_overlap_factor.dart';


class BlurText extends StatefulWidget {
  final String text;
  final AnimationType type;
  final AnimationMode mode;
  final TextAlignment textAlignment;
  final double overlapFactor;
  final Duration duration;
  final TextStyle? textStyle;
  const BlurText({
    super.key,
    required this.text,
    this.mode = AnimationMode.forward,
    this.overlapFactor = kOverlapFactor,
    this.textAlignment = TextAlignment.start,
    this.textStyle,
    this.type = AnimationType.word,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  State<BlurText> createState() => BlurTextState();
}

class BlurTextState extends State<BlurText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _opacities;
  late List<Animation<double>> _blurSigmaList;
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

    // Creating the opacity animation with staggered delays.
    _opacities = _data.map((data) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        curvedAnimation(
          _controller,
          data.index,
          intervalStep,
          overlapFactor,
          curve: Curves.easeIn,
        ),
      );
    }).toList();

    // Creating the blur sigma value animation
    _blurSigmaList = _data.map((data) {
      return Tween<double>(begin: 10.0, end: 0.0).animate(
        curvedAnimation(
          _controller,
          data.index,
          intervalStep,
          overlapFactor,
          curve: Curves.easeIn,
        ),
      );
    }).toList();
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return RichText(
          textAlign: textAlignByTextAlign(widget.textAlignment),
          text: TextSpan(
            children: _data
                .map(
                  (data) => WidgetSpan(
                    child: Opacity(
                      opacity: _opacities[data.index].value,
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(
                          sigmaX: _blurSigmaList[data.index].value,
                          sigmaY: _blurSigmaList[data.index].value,
                          tileMode: TileMode.decal,
                        ),
                        child: Text(
                          data.text,
                          style: widget.textStyle,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
