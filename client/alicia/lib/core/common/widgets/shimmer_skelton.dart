import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSkelton extends StatelessWidget {
  const ShimmerSkelton({super.key, required this.height, required this.width, this.color = const Color.fromARGB(132, 191, 190, 190), this.borderRadius});
  final double height;
  final double width;
  final Color color;
  final BorderRadius? borderRadius;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: color,
      highlightColor: Colors.white,
      period: const Duration(milliseconds: 1300),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius ??  BorderRadius.circular(10),
          color: color,
        )
      ),
    );
  }
}