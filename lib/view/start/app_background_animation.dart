import 'dart:ui';

import 'package:bluetrack/core/components/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class APPBakgroundAnimation extends StatelessWidget {
  final List<Color>? colors;
  const APPBakgroundAnimation({this.colors, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: 100.w,
            bottom: 100.h,
            child: Opacity(
              opacity: .3,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors:
                        colors ??
                        [
                          HexColor('#CA7842').withOpacity(.8),
                          HexColor('#CA7842').withOpacity(.75),
                          HexColor('#CA7842').withOpacity(.7),
                          HexColor('#CA7842').withOpacity(.65),
                        ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcATop,
                child: Image.asset(
                  "assets/icons/Spline.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: .3,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: const SizedBox(),
              ),
            ),
          ),
          // const Opacity(
          //   opacity: .4,
          //   child: images.RiveAnimation.asset(
          //     "assets/rive/shapes.riv",
          //   ),
          // ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
