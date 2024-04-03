import 'package:flutter/material.dart';

class CirCularAnimation extends StatefulWidget {
  final Widget widget;
  const CirCularAnimation({super.key, required this.widget});

  @override
  State<CirCularAnimation> createState() => _CirCularAnimationState();
}

class _CirCularAnimationState extends State<CirCularAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000));
    _animationController?.forward();
    _animationController?.repeat();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_animationController!),
      child: widget.widget,
    );
  }
}
