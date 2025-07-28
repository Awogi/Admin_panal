import 'package:flutter/material.dart';
class SlideInTextAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final Offset beginOffset;
  final Offset endOffset;

  const SlideInTextAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.easeOut,
    this.beginOffset = const Offset(0, -0.5), 
    this.endOffset = Offset.zero, 
  }) : super(key: key);

  @override
  _SlideInTextAnimationState createState() => _SlideInTextAnimationState();
}

class _SlideInTextAnimationState extends State<SlideInTextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: widget.beginOffset,
      end: widget.endOffset,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant SlideInTextAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration ||
        oldWidget.curve != widget.curve ||
        oldWidget.beginOffset != widget.beginOffset ||
        oldWidget.endOffset != widget.endOffset) {
      _controller.duration = widget.duration;
      _slideAnimation = Tween<Offset>(
        begin: widget.beginOffset,
        end: widget.endOffset,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: widget.curve,
        ),
      );
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: widget.child,
    );
  }
}
