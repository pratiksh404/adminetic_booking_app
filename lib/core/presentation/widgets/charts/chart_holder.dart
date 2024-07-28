import 'package:adminetic_booking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ChartHolder extends StatelessWidget {
  final Widget chart;
  final String name;
  final double? height;

  const ChartHolder({
    super.key,
    required this.chart,
    required this.name,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const SizedBox(width: 6),
            Text(
              name,
              style: const TextStyle(
                color: AppColors.textLight,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Container(
          height: height ?? 200,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: chart,
        ),
      ],
    );
  }
}
