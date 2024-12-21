import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kinematic_chain_path_finding/app_state.dart';
import 'package:kinematic_chain_path_finding/drag_value.dart';
import 'package:kinematic_chain_path_finding/header_text.dart';

class PathFinding extends StatefulWidget {
  const PathFinding({
    super.key,
    required AppState appState,
  }) : _appState = appState;

  final AppState _appState;

  @override
  State<PathFinding> createState() => _PathFindingState();
}

class _PathFindingState extends State<PathFinding>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  double _durationInSeconds = 2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration.zero,
      vsync: this,
    );

    _animation = Tween<double>(begin: 1, end: 0).animate(_controller)
      ..addListener(() {
        widget._appState.updateAnimation(_animation.value);
      });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const HeaderText('Path Finding'),
        const SizedBox(
          height: 10,
        ),
        FilledButton.tonal(
          onPressed: widget._appState.computeFloodFill,
          child: const Text('Compute'),
        ),
        Center(
          child: SizedBox(
            width: 360,
            height: 360,
            child: Observer(
              builder: (_) => widget._appState.floodFillIsBeingComputed
                  ? const CircularProgressIndicator()
                  : widget._appState.image != null
                      ? CustomPaint(
                          painter:
                              TextureCanvasPainter(widget._appState.image!),
                          size: const Size(360, 360),
                        )
                      : Container(),
            ),
          ),
        ),
        FilledButton.tonal(
          onPressed: () {
            _controller
              ..duration = Duration(seconds: _durationInSeconds.toInt())
              ..forward(from: 0);
          },
          child: const Text('Run'),
        ),
        DragValue(
          text: 'duration',
          value: _durationInSeconds,
          max: 30,
          min: 1,
          divisions: 29,
          onChanged: (v) {
            setState(() {
              _durationInSeconds = v;
            });
          },
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
