import 'package:blogsphere/Custom_Widget/Animated_Text/enums/text_alignment.dart';
import 'package:flutter/material.dart';

WrapAlignment wrapAlignmentByTextAlign(TextAlignment align) => switch (align) {
      TextAlignment.start => WrapAlignment.start,
      TextAlignment.center => WrapAlignment.center,
      TextAlignment.end => WrapAlignment.end,
      TextAlignment.spaceAround => WrapAlignment.spaceAround,
      TextAlignment.spaceBetween => WrapAlignment.spaceBetween,
      TextAlignment.spaceEvenly => WrapAlignment.spaceEvenly,
    };
