import 'package:blogsphere/Custom_Widget/Animated_Text/extensions/animation_playback_mode.dart';
import 'package:blogsphere/Custom_Widget/Animated_Text/utils/text_transformation.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../dto/dto.dart';
import '../enums/animation_type.dart';
import '../enums/slide_animation_type.dart';
import '../enums/text_alignment.dart';
import '../utils/custom_curved_animation.dart';
import '../utils/interval_step_by_overlap_factor.dart';
import '../utils/offset_tween_by_slide_type.dart';
import '../utils/spring_curve.dart';
import '../utils/total_duration.dart';
import '../utils/wrap_alignment_by_text_align.dart';


class OffsetText extends StatefulWidget {
  final String text;
  final AnimationMode mode;
  final AnimationType type;
  final double overlapFactor;
  final TextAlignment textAlignment;
  final SlideAnimationType slideType;
  final Duration duration;
  final TextStyle? textStyle;
  final bool isInfinite;

  const OffsetText({
    super.key,
    required this.text,
    this.mode = AnimationMode.forward,
    this.overlapFactor = kOverlapFactor,
    this.textAlignment = TextAlignment.start,
    this.textStyle,
    this.type = AnimationType.word,
    this.slideType = SlideAnimationType.topBottom,
    this.duration = const Duration(milliseconds: 200),
    this.isInfinite = false, // Default is not infinite
  });

  @override
  OffsetTextState createState() => OffsetTextState();
}

class OffsetTextState extends State<OffsetText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _offsets;
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

    // Creating the offset animations with staggered delays.
    _offsets = _data
        .map(
          (data) => offsetTweenBySlideType(
        widget.slideType,
        index: data.index,
      ).animate(
        curvedAnimation(
          _controller,
          data.index,
          intervalStep,
          overlapFactor,
          curve: SpringCurve(),
        ),
      ),
    )
        .toList();

    // Create opacity animations with staggered starts
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

    // Start the animation
    if (widget.isInfinite) {
      _controller.repeat(reverse: true); // Infinite loop
    } else {
      _controller.forward();
    }
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
    Future.delayed(const Duration(milliseconds: 5), () {
      _controller.animationByMode(widget.mode);
    });
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
      child: Transform.translate(
        offset: _offsets[data.index].value,
        child: child,
      ),
    );
  }
}
