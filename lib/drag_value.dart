import 'package:flutter/material.dart';

class DragValue extends StatelessWidget {
  const DragValue({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
  });

  final String text;
  final double value;
  final void Function(double) onChanged;
  final double min;
  final double max;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(text),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
        ),
        Text(value.toStringAsFixed(2)),
      ],
    );
  }
}
