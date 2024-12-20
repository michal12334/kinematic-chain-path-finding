import 'dart:math';

class Robot {
  Robot({
    required this.l1,
    required this.l2,
    required this.x,
    required this.y,
    this.x1,
    this.y1,
    this.x2,
    this.y2,
  });

  factory Robot.fromInverse({
    required double l1,
    required double l2,
    required double x,
    required double y,
  }) {
    double? x1, x2, y1, y2;

    if (y == 0) {
      x1 = x2 = (l1 * l1 - l2 * l2 + x * x) / (2 * x);
      y1 = sqrt(l1 * l1 - pow(l1 * l1 - l2 * l2 + x * x, 2) / (4 * x * x));
      y2 = -y1;
    } else if (x * x + y * y > 0 && (l1 + l2) * (l1 + l2) >= x * x + y * y) {
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

    return Robot(l1: l1, l2: l2, x: x, y: y, x1: x1, y1: y1, x2: x2, y2: y2);
  }

  factory Robot.fromAngles(double l1, double l2, double a1, double a2) {
    final x1 = l1 * cos(a1);
    final y1 = l1 * sin(a1);
    final x = x1 + l2 * cos(a2);
    final y = y1 + l2 * sin(a2);

    return Robot(l1: l1, l2: l2, x: x, y: y, x1: x1, y1: y1);
  }

  final double l1;
  final double l2;
  final double x;
  final double y;

  late final double? x1;
  late final double? y1;
  late final double? x2;
  late final double? y2;
}
