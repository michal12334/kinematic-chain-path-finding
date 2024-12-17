import 'package:flutter/material.dart';

class PathFinding extends StatelessWidget {
  const PathFinding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FilledButton.tonal(
          onPressed: () {},
          child: const Text('Compute'),
        )
      ],
    );
  }
}
