import 'package:blogsphere/Custom_Widget/Animated_Text/enums/text_alignment.dart';
import 'package:flutter/material.dart';


TextAlign textAlignByTextAlign(TextAlignment align) => switch (align) {
      TextAlignment.start => TextAlign.start,
      TextAlignment.center => TextAlign.center,
      TextAlignment.end => TextAlign.end,
      _ => TextAlign.justify,
    };
