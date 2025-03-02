import 'package:flutter/material.dart';
import 'package:kinematic_chain_path_finding/app_state.dart';
import 'package:kinematic_chain_path_finding/robot.dart';

class ScenePainter extends CustomPainter {
  ScenePainter({
    super.repaint,
    required Robot robot,
    required Robot endRobot,
    required List<Obstacle> obstacles,
    required Obstacle? additionalObstacle,
  })  : _robot = robot,
        _endRobot = endRobot,
        _obstacles = obstacles,
        _additionalObstacle = additionalObstacle;

  final Robot _robot;
  final Robot _endRobot;
  final List<Obstacle> _obstacles;
  final Obstacle? _additionalObstacle;

  @override
  void paint(Canvas canvas, Size size) {
    if (_robot.x1 != null) {
      _drawRobot(
        canvas,
        size,
        _robot.x1!,
        _robot.y1!,
        _robot.x,
        _robot.y,
        Colors.white,
      );
    }

    if (_endRobot.x1 != null) {
      _drawRobot(
        canvas,
        size,
        _endRobot.x1!,
        _endRobot.y1!,
        _endRobot.x,
        _endRobot.y,
        Colors.white54,
      );
    }

    for (final o in _obstacles) {
      _drawObstacle(canvas, size, o, Colors.red);
    }

    if (_additionalObstacle != null) {
      _drawObstacle(canvas, size, _additionalObstacle, Colors.yellow);
    }
  }

  void _drawRobot(
    Canvas canvas,
    Size size,
    double x1,
    double y1,
    double x,
    double y,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4;

    final c0 = _getNormalizedCoords(0, 0, size);
    final c1 = _getNormalizedCoords(x1, y1, size);
    final c2 = _getNormalizedCoords(x, y, size);

    canvas
      ..drawLine(Offset(c0.$1, c0.$2), Offset(c1.$1, c1.$2), paint)
      ..drawLine(Offset(c1.$1, c1.$2), Offset(c2.$1, c2.$2), paint);
  }

  void _drawObstacle(
    Canvas canvas,
    Size size,
    Obstacle obstacle,
    Color color,
  ) {
    final paint = Paint()..color = color;

    final c0 = _getNormalizedCoords(obstacle.startX, obstacle.startY, size);
    final c1 = _getNormalizedCoords(obstacle.endX, obstacle.endY, size);

    canvas.drawRect(
      Rect.fromPoints(Offset(c0.$1, c0.$2), Offset(c1.$1, c1.$2)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  (double x, double y) _getNormalizedCoords(double x, double y, Size size) {
    final rx = (x + 1) / 2 * size.width;
    final ry = (-y + 1) / 2 * size.height;
    return (rx, ry);
  }
}
