import 'package:alicia/core/config/style/colors.dart';
import 'package:alicia/features/home/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportButton extends ConsumerWidget {
  const ReportButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final response = await ref.read(homeProvider.notifier).getReportUrl();
          if (response.isLeft) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(response.left.message),
                backgroundColor: AliciaColors.red,
              ),
            );
          }
          print("Report URL: ${response.right}");
        },
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: null,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: AliciaColors.deepPurple.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Generar reporte',
                style: TextStyle(
                  color: AliciaColors.darkText.withOpacity(0.5),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.document_scanner_outlined,
                size: 20,
                color: AliciaColors.darkText.withOpacity(0.35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}