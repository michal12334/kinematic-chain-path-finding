import 'dart:math';
import 'dart:ui';

import 'package:kinematic_chain_path_finding/app_state.dart';

class Robot {
  Robot({
    required this.l1,
    required this.l2,
    required this.x,
    required this.y,
    this.x1,
    this.y1,
  });

  factory Robot.fromInverse({
    required double l1,
    required double l2,
    required double x,
    required double y,
    required List<Obstacle> obstacles,
    required RobotPositionType positionType,
  }) {
    double? x1, x2, y1, y2;

    if (y == 0) {
      x1 = x2 = (l1 * l1 - l2 * l2 + x * x) / (2 * x);
      y1 = sqrt(l1 * l1 - pow(l1 * l1 - l2 * l2 + x * x, 2) / (4 * x * x));
      y2 = -y1;
    } else if (x * x + y * y > 0 &&
        (l1 + l2) * (l1 + l2) >= x * x + y * y &&
        (l1 - l2) * (l1 - l2) <= x * x + y * y) {
      x1 = 1 /
          (2 * (x * x + y * y)) *
          (-sqrt(
                -y *
                    y *
                    (-2 * l1 * l1 * x * x -
                        2 * l2 * l2 * x * x -
                        2 * l1 * l1 * y * y -
                        2 * l2 * l2 * y * y +
                        l1 * l1 * l1 * l1 +
                        l2 * l2 * l2 * l2 -
                        2 * l1 * l1 * l2 * l2 +
                        x * x * x * x +
                        2 * x * x * y * y +
                        y * y * y * y),
              ) +
              l1 * l1 * x -
              l2 * l2 * x +
              x * x * x +
              x * y * y);
      y1 = 1 /
          (2 * y * (x * x + y * y)) *
          (x *
                  sqrt(
                    -y *
                        y *
                        (-2 * l1 * l1 * x * x -
                            2 * l2 * l2 * x * x -
                            2 * l1 * l1 * y * y -
                            2 * l2 * l2 * y * y +
                            l1 * l1 * l1 * l1 +
                            l2 * l2 * l2 * l2 -
                            2 * l1 * l1 * l2 * l2 +
                            x * x * x * x +
                            2 * x * x * y * y +
                            y * y * y * y),
                  ) +
              l1 * l1 * y * y -
              l2 * l2 * y * y +
              x * x * y * y +
              y * y * y * y);
      x2 = 1 /
          (2 * (x * x + y * y)) *
          (sqrt(
                -y *
                    y *
                    (-2 * l1 * l1 * x * x -
                        2 * l2 * l2 * x * x -
                        2 * l1 * l1 * y * y -
                        2 * l2 * l2 * y * y +
                        l1 * l1 * l1 * l1 +
                        l2 * l2 * l2 * l2 -
                        2 * l1 * l1 * l2 * l2 +
                        x * x * x * x +
                        2 * x * x * y * y +
                        y * y * y * y),
              ) +
              l1 * l1 * x -
              l2 * l2 * x +
              x * x * x +
              x * y * y);
      y2 = 1 /
          (2 * y * (x * x + y * y)) *
          (-x *
                  sqrt(
                    -y *
                        y *
                        (-2 * l1 * l1 * x * x -
                            2 * l2 * l2 * x * x -
                            2 * l1 * l1 * y * y -
                            2 * l2 * l2 * y * y +
                            l1 * l1 * l1 * l1 +
                            l2 * l2 * l2 * l2 -
                            2 * l1 * l1 * l2 * l2 +
                            x * x * x * x +
                            2 * x * x * y * y +
                            y * y * y * y),
                  ) +
              l1 * l1 * y * y -
              l2 * l2 * y * y +
              x * x * y * y +
              y * y * y * y);
    } else {
      x1 = x2 = y1 = y2 = null;
    }

    if ((positionType == RobotPositionType.alternative && y >= 0) ||
        (positionType == RobotPositionType.basic && y < 0)) {
      x1 = x2;
      y1 = y2;
    }

    for (final o in obstacles) {
      if (x1 != null && (_hit(o, 0, 0, x1, y1!) || _hit(o, x1, y1, x, y))) {
        x1 = y1 = null;
      }
    }

    return Robot(l1: l1, l2: l2, x: x, y: y, x1: x1, y1: y1);
  }

  factory Robot.fromAngles(
    double l1,
    double l2,
    double a1,
    double a2,
    List<Obstacle> obstacles,
  ) {
    var x1 = l1 * cos(a1) as double?;
    var y1 = l1 * sin(a1) as double?;
    final x = x1! + l2 * cos(a2);
    final y = y1! + l2 * sin(a2);

    for (final o in obstacles) {
      if (x1 != null && (_hit(o, 0, 0, x1, y1!) || _hit(o, x1, y1, x, y))) {
        x1 = y1 = null;
      }
    }

    return Robot(l1: l1, l2: l2, x: x, y: y, x1: x1, y1: y1);
  }

  static bool _hit(
    Obstacle obstacle,
    double x0,
    double y0,
    double x1,
    double y1,
  ) {
    final p1 = Offset(x0, y0);
    final p2 = Offset(x1, y1);
    final q1 = Offset(obstacle.startX, obstacle.startY);
    final q2 = Offset(obstacle.startX, obstacle.endY);
    final q3 = Offset(obstacle.endX, obstacle.startY);
    final q4 = Offset(obstacle.endX, obstacle.endY);
    return _doLineSegmentsHit(p1, p2, q1, q2) ||
        _doLineSegmentsHit(p1, p2, q1, q3) ||
        _doLineSegmentsHit(p1, p2, q2, q4) ||
        _doLineSegmentsHit(p1, p2, q3, q4);
  }

  static bool _doLineSegmentsHit(Offset p1, Offset p2, Offset q1, Offset q2) {
    double cross(Offset a, Offset b) => a.dx * b.dy - a.dy * b.dx;

    Offset subtract(Offset a, Offset b) => Offset(a.dx - b.dx, a.dy - b.dy);

    final d1 = cross(subtract(q2, q1), subtract(p1, q1));
    final d2 = cross(subtract(q2, q1), subtract(p2, q1));
    final d3 = cross(subtract(p2, p1), subtract(q1, p1));
    final d4 = cross(subtract(p2, p1), subtract(q2, p1));

    return (d1 * d2 < 0) && (d3 * d4 < 0);
  }

  final double l1;
  final double l2;
  final double x;
  final double y;

  late final double? x1;
  late final double? y1;
}
