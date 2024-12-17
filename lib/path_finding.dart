import 'package:flutter/material.dart';
import 'package:kinematic_chain_path_finding/header_text.dart';

class PathFinding extends StatelessWidget {
  const PathFinding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const HeaderText('Path Finding'),
        const SizedBox(
          height: 10,
        ),
        FilledButton.tonal(
          onPressed: () {},
          child: const Text('Compute'),
        ),
      ],
    );
  }
}
