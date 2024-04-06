import 'package:alicia/core/config/style/colors.dart';
import 'package:alicia/features/home/widgets/mood_bar_chart.dart';
import 'package:flutter/material.dart';

class MoodCounter extends StatelessWidget {
  const MoodCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AliciaColors.lightPurple,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ]),
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 20,
            child: Text(
              'Tu mood chart',
              style: TextStyle(
                color: AliciaColors.darkText,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(right: 25, left: 25, top: 75),
              child: MoodBarChart(),
            )
          ),
        ],
      ),
    );
  }
}
