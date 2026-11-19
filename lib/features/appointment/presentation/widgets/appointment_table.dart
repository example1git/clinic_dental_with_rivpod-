import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:mysen/core/utiles.dart';

class AppointmentTable extends StatelessWidget {
  const AppointmentTable({
    super.key,
    required this.title,
    required this.traling,
  });

  final String title;
  final String traling;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: context.padding * 2),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: AnimatedTextKit(
                repeatForever: false,
                totalRepeatCount: 1,

                animatedTexts: [
                  TyperAnimatedText(
                    textAlign: TextAlign.justify,
                    textStyle: context.bodyMeduim,
                    title,
                    speed: const Duration(milliseconds: 50),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: AnimatedTextKit(
                repeatForever: false,
                totalRepeatCount: 1,
                animatedTexts: [
                  TyperAnimatedText(
                    textAlign: TextAlign.center,
                    textStyle: context.number,

                    "$traling ${context.tr.sar}",
                    speed: const Duration(milliseconds: 150),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
