import 'dart:math';

class Robot {
  Robot({
    required this.l1,
    required this.l2,
    required this.x,
    required this.y,
  }) {
    if (y == 0) {
      x1 = x2 = (l1 * l1 - l2 * l2 + x * x) / (2 * x);
      y1 = sqrt(l1 * l1 - pow(l1 * l1 - l2 * l2 + x * x, 2) / (4 * x * x));
      y2 = -y1!;
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
