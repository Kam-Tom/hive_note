import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class BorderProgressBar extends StatefulWidget {
  final double strokeWidth;
  final BorderRadius borderRadius;
  final Duration duration;
  final void Function()? onLongPress;
  final void Function()? onTap;
  final Color startColor;
  final Color endColor;
  final Color backgroundColor;
  final bool isRounded;
  final Widget child;

  const BorderProgressBar({
    super.key,
    this.strokeWidth = 4,
    this.borderRadius = BorderRadius.zero,
    required this.duration,
    this.onLongPress,
    this.onTap,
    required this.startColor,
    required this.endColor,
    required this.backgroundColor,
    required this.isRounded,
    required this.child,
  });

  @override
  State<BorderProgressBar> createState() => _BorderProgressBarState();
}

class _BorderProgressBarState extends State<BorderProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  late Animation<Color?> _colorAnimation;
  Timer? _longPressTimer;
  var _longPress = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _progressAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
          ..addListener(() {
            setState(() {});
          });

    _colorAnimation = ColorTween(begin: widget.startColor, end: widget.endColor)
        .animate(_controller);
  }

  void _handlePress() {
    _longPress = false;
    _longPressTimer = Timer(const Duration(milliseconds: 100), () {
      _longPress = true;
    });

    _controller.forward().whenComplete(
          () =>  widget.onLongPress?.call(),

        );
  }

  void _handleRelease() {
    _longPressTimer?.cancel();
    if(!_longPress) widget.onTap?.call();
    _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _handlePress(),
      onTapUp: (_) => _handleRelease(),
      onTapCancel: _handleRelease, // Handle case when the press is canceled
      child: CustomPaint(
        painter: _BackgroundPainter(
            strokeWidth: widget.strokeWidth,
            borderRadius: widget.borderRadius,
            backgroundColor: widget.backgroundColor,
            isRounded: widget.isRounded),
        child: CustomPaint(
          painter: _ProgressPainter(
            progress: _progressAnimation.value,
            strokeWidth: widget.strokeWidth,
            borderRadius: widget.borderRadius,
            progressColor: _colorAnimation.value ?? widget.startColor,
            isRounded: widget.isRounded,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final double strokeWidth;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final bool isRounded;

  _BackgroundPainter({
    required this.strokeWidth,
    required BorderRadius borderRadius,
    required this.backgroundColor,
    required this.isRounded,
  }) : borderRadius = BorderRadius.only(
          topLeft: _adjustRadius(borderRadius.topLeft, strokeWidth),
          topRight: _adjustRadius(borderRadius.topRight, strokeWidth),
          bottomLeft: _adjustRadius(borderRadius.bottomLeft, strokeWidth),
          bottomRight: _adjustRadius(borderRadius.bottomRight, strokeWidth),
        );

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = isRounded ? StrokeCap.round : StrokeCap.butt;

    Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(borderRadius.topLeft.x, 0)
      ..arcToPoint(Offset(0, borderRadius.topLeft.y),
          radius: borderRadius.topLeft, clockwise: false)
      ..lineTo(0, size.height - borderRadius.bottomLeft.y)
      ..arcToPoint(Offset(borderRadius.bottomLeft.x, size.height),
          radius: borderRadius.bottomLeft, clockwise: false)
      ..lineTo(size.width - borderRadius.bottomRight.x, size.height)
      ..arcToPoint(Offset(size.width, size.height - borderRadius.bottomRight.y),
          radius: borderRadius.bottomRight, clockwise: false)
      ..lineTo(size.width, borderRadius.topRight.y)
      ..arcToPoint(Offset(size.width - borderRadius.topRight.x, 0),
          radius: borderRadius.topRight, clockwise: false)
      ..lineTo(size.width / 2, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _ProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final BorderRadius borderRadius;
  final Color progressColor;
  final bool isRounded;

  _ProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required BorderRadius borderRadius,
    required this.progressColor,
    required this.isRounded,
  }) : borderRadius = BorderRadius.only(
          topLeft: _adjustRadius(borderRadius.topLeft, strokeWidth),
          topRight: _adjustRadius(borderRadius.topRight, strokeWidth),
          bottomLeft: _adjustRadius(borderRadius.bottomLeft, strokeWidth),
          bottomRight: _adjustRadius(borderRadius.bottomRight, strokeWidth),
        );

  @override
  void paint(Canvas canvas, Size size) {
    if (progress == 0) return;

    Paint paint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = isRounded ? StrokeCap.round : StrokeCap.butt;

    Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(borderRadius.topLeft.x, 0)
      ..arcToPoint(Offset(0, borderRadius.topLeft.y),
          radius: borderRadius.topLeft, clockwise: false)
      ..lineTo(0, size.height - borderRadius.bottomLeft.y)
      ..arcToPoint(Offset(borderRadius.bottomLeft.x, size.height),
          radius: borderRadius.bottomLeft, clockwise: false)
      ..lineTo(size.width - borderRadius.bottomRight.x, size.height)
      ..arcToPoint(Offset(size.width, size.height - borderRadius.bottomRight.y),
          radius: borderRadius.bottomRight, clockwise: false)
      ..lineTo(size.width, borderRadius.topRight.y)
      ..arcToPoint(Offset(size.width - borderRadius.topRight.x, 0),
          radius: borderRadius.topRight, clockwise: false)
      ..lineTo(size.width / 2, 0);

    // If you want the animation to start from the bottom and move to the top, use the following path definition:
    // Path path = Path()
    //  ..moveTo(size.width/2, size.height)
    //  ..lineTo(borderRadius.bottomLeft.x, size.height)
    //  ..arcToPoint(Offset(0, size.height - borderRadius.bottomLeft.y), radius: borderRadius.bottomLeft, clockwise: true)
    //  ..lineTo(0, borderRadius.topLeft.y)
    //  ..arcToPoint(Offset(borderRadius.topLeft.x, 0), radius: borderRadius.topLeft, clockwise: true)
    //  ..lineTo(size.width - borderRadius.topRight.x, 0)
    //  ..arcToPoint(Offset(size.width, borderRadius.topRight.y), radius: borderRadius.topRight, clockwise: true)
    //  ..lineTo(size.width, size.height - borderRadius.bottomRight.y)
    //  ..arcToPoint(Offset(size.width - borderRadius.bottomRight.x, size.height), radius: borderRadius.bottomRight, clockwise: true)
    //  ..lineTo(size.width/2, size.height);

    PathMetric pathMetric = path.computeMetrics().first;

    Path extractPath = pathMetric.extractPath(
      pathMetric.length * (0.5 * (1 - progress)),
      pathMetric.length * (0.5 + 0.5 * progress),
    );

    canvas.drawPath(extractPath, paint);
  }

  @override
  bool shouldRepaint(covariant _ProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.isRounded != isRounded;
  }
}

Radius _adjustRadius(Radius radius, double strokeWidth) {
  return radius == Radius.zero
      ? Radius.zero
      : Radius.circular(radius.x + strokeWidth / 2);
}