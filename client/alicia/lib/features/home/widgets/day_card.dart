import 'package:alicia/core/config/style/colors.dart';
import 'package:alicia/features/home/models/day.dart';
import 'package:flutter/material.dart';

class DayCard extends StatelessWidget {
  const DayCard({required this.filled, required this.day, required this.dayNumber, super.key});
  final bool filled;
  final Day day;
  final int dayNumber;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 60,
      decoration: BoxDecoration(
        color: filled ? AliciaColors.accentPurple : AliciaColors.backgroundWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 3),
        )]
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day.label,
              style: TextStyle(
                color: filled ? AliciaColors.backgroundWhite : AliciaColors.darkText,
                fontSize: 15,
                fontWeight: filled? FontWeight.bold : FontWeight.w500,
              ),
            ),
            Text(
              dayNumber.toString(),
              style: TextStyle(
                color: filled ? AliciaColors.backgroundWhite : AliciaColors.darkText,
                fontSize: 15,
                fontWeight: filled? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ])),
    );
  }
}