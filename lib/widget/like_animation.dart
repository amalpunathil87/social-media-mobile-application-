import 'package:flutter/material.dart';

class like_animation extends StatefulWidget {
  final Widget child;
  final bool isanimation;
  final Duration duration;
  final VoidCallback? onend;
  final bool smalllike;

  const like_animation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 150),
    required this.isanimation,
    this.onend,
    this.smalllike = false,
  });

  @override
  State<like_animation> createState() => _like_animationState();
}

class _like_animationState extends State<like_animation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(microseconds: widget.duration.inMilliseconds ~/ 2));
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

  @override
  void didUpdateWidget(covariant like_animation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isanimation != oldWidget.isanimation) {
      startanimation();
    }
  }

  startanimation() async {
    if (widget.isanimation || widget.smalllike) {
      await controller.forward();
      await controller.reverse();
      await Future.delayed(
        const Duration(
          milliseconds: 200,
        ),
      );
      if (widget.onend != null) {
        widget.onend!();
      }
    }
  }

  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
