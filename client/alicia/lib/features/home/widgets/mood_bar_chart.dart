import 'package:alicia/core/config/style/colors.dart';
import 'package:alicia/features/home/models/mood.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MoodBarChart extends StatefulWidget {
  const MoodBarChart({super.key, required this.moodMap});
  final Map<Mood, int> moodMap;
  @override
  State<MoodBarChart> createState() => _MoodBarChartState();
}

class _MoodBarChartState extends State<MoodBarChart> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
      alignment: BarChartAlignment.spaceBetween,
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => AliciaColors.accentPurple,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String label = Mood.values[group.x].label;
            return BarTooltipItem(
              '$label\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: [
                TextSpan(
                  text: (rod.toY - 1).toString(),
                  style: TextStyle(
                    color: AliciaColors.backgroundWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) => SideTitleWidget(
                axisSide: meta.axisSide,
                space: 8,
                child: Text(Mood.values[value.toInt()].label,
                    style: TextStyle(
                      color: AliciaColors.darkText,
                      fontSize: 13,
                    ))),
            reservedSize: 45,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(widget.moodMap),
      gridData: const FlGridData(show: false),
    ));
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 25,
    List<int> showTooltips = const [],
  }) {
    barColor ??= Mood.values[x].color;
    double toY = widget.moodMap.values.reduce((value, element) {
          return value > element ? value : element;
        }).toDouble() *
        3;
    if (toY == 0) toY = 1;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? const Color(0xFF00FFA3) : barColor,
          width: width,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          borderSide: isTouched
              ? const BorderSide(color: Color.fromARGB(178, 0, 255, 162))
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: toY,
            color: AliciaColors.backgroundWhite,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(Map<Mood, int> moodMap) => List.generate(5, (i) {
        return makeGroupData(i, moodMap[Mood.values[i]]!.toDouble(), isTouched: i == touchedIndex);
      });
}
