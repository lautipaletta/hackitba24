import 'package:alicia/core/config/style/colors.dart';
import 'package:flutter/material.dart';

class ReportContainer extends StatelessWidget {
  const ReportContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: null,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: AliciaColors.darkText.withOpacity(0.3),
                  width: 1.5,
                )),
            child: Padding(
              padding: const EdgeInsets.all(20.0).copyWith(bottom: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: const Text(
                        "Lautaro informa que ha estado experimentando niveles significativos de estrés y ansiedad en las últimas semanas, lo que ha afectado su concentración y rendimiento académico",
                        overflow: TextOverflow.fade),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Compartir',
                          style: TextStyle(
                            color: AliciaColors.accentPurple.withOpacity(0.5),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.share_outlined,
                          size: 20,
                          color: AliciaColors.darkText.withOpacity(0.35),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
