import 'package:flutter/material.dart';

class TemperatureHighLow extends StatelessWidget {
  const TemperatureHighLow({
    required this.temp,
    required this.label,
    required this.alignment,
    super.key,
  });

  final int temp;
  final String label;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withValues(alpha: 0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '$temp°',
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
