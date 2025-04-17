import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class CustomScrollText extends StatelessWidget {
  const CustomScrollText({
    super.key,
    required this.text,
    this.style,
    this.height,
    this.pauseAfterRound = const Duration(seconds: 1),
    this.velocity = 30.0,
  });

  final String text;
  final TextStyle? style;
  final double? height;
  final Duration pauseAfterRound;
  final double velocity;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(
              text: text, style: style ?? DefaultTextStyle.of(context).style),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: double.infinity);

        final textWidth = textPainter.size.width;
        final boxWidth = constraints.maxWidth;

        if (textWidth > boxWidth) {
          return SizedBox(
            height: height,
            child: Marquee(
              text: text,
              style: style,
              scrollAxis: Axis.horizontal,
              blankSpace: 40.0,
              velocity: velocity,
              pauseAfterRound: pauseAfterRound,
              startPadding: 0.0,
              accelerationDuration: const Duration(milliseconds: 500),
              decelerationDuration: const Duration(milliseconds: 500),
            ),
          );
        } else {
          return SizedBox(
            height: height,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: style,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        }
      },
    );
  }
}
