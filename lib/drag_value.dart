import 'package:flutter/material.dart';

class DragValue extends StatelessWidget {
  const DragValue({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.width,
  });

  final String text;
  final double value;
  final void Function(double) onChanged;
  final double min;
  final double max;
  final int? divisions;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(text),
            ),
            Flexible(
              child: Slider(
                value: value,
                min: min,
                max: max,
                onChanged: onChanged,
                divisions: divisions,
              ),
            ),
            Text(value.toStringAsFixed(2)),
          ],
        ),
      ),
    );
  }
}
