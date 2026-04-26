import 'package:flutter/material.dart';

class SlideUpWidget extends StatefulWidget {
  final Widget child;
  final double targetBottom;
  final Duration delay;
  final Duration duration;

  const SlideUpWidget({
    super.key,
    required this.child,
    this.targetBottom = 50,
    this.delay = const Duration(milliseconds: 100),
    this.duration = const Duration(milliseconds: 700),
  });

  @override
  State<SlideUpWidget> createState() => _SlideUpWidgetState();
}

class _SlideUpWidgetState extends State<SlideUpWidget> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: widget.duration,
      curve: Curves.easeOut,
      bottom: _visible ? widget.targetBottom : -100,
      left: 0,
      right: 0,
      child: Center(child: widget.child),
    );
  }
}
