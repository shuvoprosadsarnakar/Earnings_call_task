import 'package:flutter/material.dart';

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;

  const CustomSliderThumbCircle({required this.thumbRadius});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
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
    final Canvas canvas = context.canvas;

    final circle = Paint()
      ..color = const Color.fromRGBO(77, 236, 140, 1) //Thumb Background Color
      ..style = PaintingStyle.fill;

    final border = Paint()
      ..color = const Color.fromRGBO(0, 0, 51, .25) //Thumb Background Color
      ..style = PaintingStyle.fill;

    final Tween<double> radiusTween = Tween<double>(
      begin: 10,
      end: 12,
    );

    canvas.drawCircle(
        center, radiusTween.evaluate(activationAnimation), border);
    canvas.drawCircle(center, thumbRadius * .70, circle);
  }
}
