import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoApp extends StatefulWidget {
  final bool? isRotate;
  final double? width;
  const LogoApp({Key? key, this.isRotate, this.width}) : super(key: key);

  @override
  State<LogoApp> createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 3, vsync: this);
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.isRotate ?? false)
        ? MatrixTransition(
            animation: _animation,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                semanticsLabel: 'My SVG Image',
                width: 45,
              ),
            ),
            onTransform: (double value) {
              return Matrix4.identity()
                ..setEntry(3, 2, 0.004)
                ..rotateY(pi * 2.0 * value);
            },
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              semanticsLabel: 'My SVG Image',
              width: widget.width ?? 45,
            ),
          );
  }
}
