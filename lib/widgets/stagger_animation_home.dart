import 'package:flutter/material.dart';
import 'package:lojacompleta/widgets/home_top.dart';

class StaggerAnimationHome extends StatelessWidget {
  StaggerAnimationHome({this.controller})
      : containerGrow = CurvedAnimation(
          parent: controller!,
          curve: Curves.ease,
        );

  final AnimationController? controller;

  final Animation<double>? containerGrow;

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        HomeTop(containerGrow: containerGrow!),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: AnimatedBuilder(
          animation: controller!,
          builder: _buildAnimation,
        ),
      ),
    );
  }
}
