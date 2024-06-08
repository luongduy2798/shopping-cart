import 'dart:async';

import 'package:flutter/material.dart';

class MotionButton extends StatefulWidget {
  final Widget child;
  final Function()? onTap;
  final double scale;
  const MotionButton(
      {super.key, required this.child, this.onTap, this.scale = 0.7});

  @override
  _MotionButtonState createState() => _MotionButtonState();
}

class _MotionButtonState extends State<MotionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation =
        Tween<double>(begin: 1, end: widget.scale).animate(_controller);
    _opacityAnimation = Tween<double>(begin: 1, end: 0.5).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: GestureDetector(
              onTap: _onTap,
              child: Container(color: Colors.transparent, child: widget.child),
            ),
          ),
        );
      },
    );
  }

  Future<void> _onTap() async {
    _controller.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    _controller.reverse();
    await Future.delayed(const Duration(milliseconds: 100));
    widget.onTap?.call();
  }
}
