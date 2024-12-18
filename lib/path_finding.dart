import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kinematic_chain_path_finding/app_state.dart';
import 'package:kinematic_chain_path_finding/header_text.dart';

class PathFinding extends StatelessWidget {
  const PathFinding({
    super.key,
    required AppState appState,
  }) : _appState = appState;

  final AppState _appState;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const HeaderText('Path Finding'),
        const SizedBox(
          height: 10,
        ),
        FilledButton.tonal(
          onPressed: _appState.computeFloodFill,
          child: const Text('Compute'),
        ),
        Center(
          child: SizedBox(
            width: 360,
            height: 360,
            child: Observer(
              builder: (_) => _appState.floodFillIsBeingComputed
                  ? const CircularProgressIndicator()
                  : _appState.image != null
                      ? CustomPaint(
                          painter: TextureCanvasPainter(_appState.image!),
                          size: const Size(360, 360),
                        )
                      : Container(),
            ),
          ),
        ),
      ],
    );
  }
}

class TextureCanvasPainter extends CustomPainter {
  TextureCanvasPainter(this.image);

  final ui.Image image;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
