import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BbLoadingLogo extends StatefulWidget {
  final Duration duration;
  final double minScale;
  final double maxScale;
  final bool onlyIcon;

  const BbLoadingLogo({
    // Renamed here
    super.key,
    this.onlyIcon = false,
    this.duration = const Duration(milliseconds: 800),
    this.minScale = 0.8,
    this.maxScale = 1.2,
  });

  @override
  BbLoadingLogoState createState() => BbLoadingLogoState(); // Renamed here
}

class BbLoadingLogoState extends State<BbLoadingLogo>
    with SingleTickerProviderStateMixin {
  // Renamed here
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);

    _animation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: _animation,
        child: widget.onlyIcon
            ? SvgPicture.asset('assets/images/BlackBullIco.svg', height: 32)
            : SvgPicture.asset('assets/images/BlackBull_w.svg', height: 32),
      ),
    );
  }
}
