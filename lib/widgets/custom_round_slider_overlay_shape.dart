import 'package:flutter/material.dart';

class CustomRoundSliderOverlayShape extends SliderComponentShape {
  final double overlayRadius;

  const CustomRoundSliderOverlayShape({required this.overlayRadius});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(overlayRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    // Removed all the material animations, circle animation is added in CustomSliderThumbCircle
  }
}
