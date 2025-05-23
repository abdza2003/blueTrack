import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Particle {
  double orbit;
  late double originalOrbit;
  late double theta;
  late double opacity;
  late Color color;

  Particle(this.orbit, this.color) {
    originalOrbit = orbit;
    theta = getRandomRange(0, 360.0) * pi / 180;
    opacity = getRandomRange(0.0, 1.0);
  }

  void update() {
    orbit += 0.1;
    opacity -= 0.0025;
    if (opacity < 0.0) {
      orbit = originalOrbit;
      opacity = getRandomRange(0.1, 1.0);
    }
  }
}

final rnd = Random();
double getRandomRange(double min, double max) {
  return rnd.nextDouble() * (max - min) + min;
}

Offset polarToCartesian(double r, double theta) {
  final dx = r * cos(theta);
  final dy = r * sin(theta);
  return Offset(dx, dy);
}

class CircleAnimationProvider with ChangeNotifier {
  double thicknesPoints = 0.0;
  double value = 0.0;
  final double speed = 10.5;
  late Timer timer;
  late List<Particle> particles;

  final double circleSize;
  final double percentage;
  final Color mainColor;
  final double? thicknesMaxPoints;

  CircleAnimationProvider({
    required this.circleSize,
    required this.percentage,
    required this.mainColor,
    this.thicknesMaxPoints,
  }) {
    particles = List<Particle>.generate(
        200, (index) => Particle(circleSize, mainColor));

    timer = Timer.periodic(const Duration(milliseconds: 1000 ~/ 60), (timer) {
      if (value <= percentage) {
        value += speed;
        notifyListeners();
      } else {
        for (var p in particles) {
          p.update();
          notifyListeners();
        }
      }
      thicknesPoints = thicknesMaxPoints ?? 1.0;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}

class CircleAnimation extends StatelessWidget {
  final double circleSize;
  final double thicknesPoints;
  final double thickness;
  final bool isAnimationRun;
  final double percentage;
  final double? thicknessBorder;
  final Color mainColor;
  final List<Color>? colors;
  final Color? borderColor;

  const CircleAnimation({
    required this.mainColor,
    this.percentage = 360,
    this.circleSize = 30,
    this.thicknesPoints = 1.0,
    this.thickness = 5,
    this.isAnimationRun = false,
    this.thicknessBorder,
    this.borderColor,
    this.colors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CircleAnimationProvider(
        circleSize: circleSize,
        percentage: percentage,
        mainColor: mainColor,
        thicknesMaxPoints: thicknesPoints,
      ),
      child: Consumer<CircleAnimationProvider>(
        builder: (context, provider, child) {
          return CustomPaint(
            painter: RadialProgressPainter(
              sizeImage: const Size(2, 2),
              context: context,
              percentage: provider.value,
              particles: provider.particles,
              thicknesCircular: provider.thicknesPoints,
              isRun: isAnimationRun,
              radialSize: circleSize,
              thickness: thickness,
              colors: colors ?? [mainColor, mainColor],
              backgroundColor:
                  borderColor ?? Theme.of(context).colorScheme.background,
              thicknessBorder: thicknessBorder ?? 3.r,
            ),
          );
        },
      ),
    );
  }
}

class RadialProgressPainter extends CustomPainter {
  final Size sizeImage;
  final BuildContext context;
  final double percentage;
  final double thicknesCircular;
  final bool isRun;
  final List<Particle> particles;
  final double radialSize;
  final double thickness;
  final double thicknessBorder;
  final Color backgroundColor;
  final List<Color> colors;

  RadialProgressPainter({
    required this.sizeImage,
    required this.context,
    required this.percentage,
    required this.particles,
    required this.thicknesCircular,
    required this.isRun,
    required this.radialSize,
    required this.thickness,
    required this.colors,
    required this.backgroundColor,
    required this.thicknessBorder,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2.0, size.height / 2.0);

    final rect = Rect.fromCenter(
        center: center,
        width: sizeImage.width * radialSize,
        height: sizeImage.height * radialSize);

    drawGuid(canvas, center, radialSize);
    drawArc(canvas, rect);
    if (isRun) {
      drawParticles(canvas, center, thicknesCircular);
    }
  }

  void drawGuid(Canvas canvas, Offset center, double radius) {
    Paint paint = Paint()
      ..strokeWidth = thicknessBorder
      ..style = PaintingStyle.stroke
      ..color = backgroundColor;
    canvas.drawCircle(center, radius, paint);
  }

  void drawArc(Canvas canvas, Rect rect) {
    Paint fgPaint = Paint()
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: colors,
        tileMode: TileMode.mirror,
      ).createShader(rect);

    const startAngle = 6 * pi / 180.0;
    final sweepAngle = percentage * pi / 180.0;

    canvas.drawArc(rect, startAngle, sweepAngle, false, fgPaint);
  }

  void drawParticles(Canvas canvas, Offset center, double thicknesCircular) {
    for (var p in particles) {
      final position = polarToCartesian(p.orbit, p.theta) + center;
      Paint paint = Paint()..color = p.color.withOpacity(p.opacity);
      canvas.drawCircle(position, thicknesCircular, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
