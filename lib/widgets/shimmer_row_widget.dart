import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerRowWidget extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Color baseColor;
  final Color highlightColor;

  const ShimmerRowWidget({
    super.key,
    required this.width,
    required this.height,
    this.radius = 10,
    this.baseColor = const Color(0xFFEEEEEE),
    this.highlightColor = const Color(0xFFF5F5F5)
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          enabled: true,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
} // ShimmerRowWidget() end