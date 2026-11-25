import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mysen/core/constant.dart';
import 'package:mysen/core/utiles.dart';
import 'package:mysen/features/auth/presentation/pages/auth_gate.dart';

class Startscreen extends StatefulWidget {
  const Startscreen({super.key});

  @override
  State<Startscreen> createState() => _StartscreenState();
}

class _StartscreenState extends State<Startscreen>
    with TickerProviderStateMixin {
  bool isWhite = false;
  bool authScreen = false;
  Color color = blackcolor;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () async {
      await Future.delayed(const Duration(milliseconds: 2500));
      setState(() {
        color = whitecolor;
        isWhite = true;
      });

      await Future.delayed(const Duration(milliseconds: 1500));
      authScreen = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = context.mediaSize;

    return authScreen == true
        ? const AuthGate()
        : Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              backgroundColor: context.primarycolor,
              body: SizedBox.expand(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: const FractionalOffset(.5, .5),
                      child: TweenAnimationBuilder(
                        duration: const Duration(seconds: 1),
                        tween: ColorTween(begin: blackcolor, end: color),
                        builder: (context, value, child) => ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [value!, whitecolor],
                          ).createShader(bounds),
                          child: FaIcon(
                            FontAwesomeIcons.tooth,
                            color: whitecolor,
                            size: size.shortestSide * .09,
                          ),
                        ),
                      ),
                    ).animate().shake(duration: const Duration(seconds: 1)),

                    Align(
                          alignment: FractionalOffset(
                            .5,
                            context.mediaSize.width > 600 ? 0.4 : .43,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text('MySen', style: context.mysen)],
                          ),
                        )
                        .animate()
                        .then(delay: const Duration(seconds: 1))
                        .fadeIn()
                        .then(delay: const Duration(seconds: 1))
                        .slideY(begin: -0.1, end: .1)
                        .then()
                        .slideY(begin: .1, end: -0.1),
                  ],
                ),
              ),
            ),
          );
  }
}
