import 'dart:collection';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kinematic_chain_path_finding/robot.dart';

part 'compute_path_finding.g.dart';

@JsonSerializable()
class AppStateData {
  AppStateData(this.l1, this.l2, this.x, this.y, this.endX, this.endY);

  factory AppStateData.fromJson(Map<String, dynamic> json) =>
      _$AppStateDataFromJson(json);

  final double l1;
  final double l2;

  final double x;
  final double y;

  final double endX;
  final double endY;

  Map<String, dynamic> toJson() => _$AppStateDataToJson(this);
}

@JsonSerializable()
class PathFindingResult {
  PathFindingResult(this.pixels);

  factory PathFindingResult.fromJson(Map<String, dynamic> json) =>
      _$PathFindingResultFromJson(json);

  final List<int> pixels;

  Map<String, dynamic> toJson() => _$PathFindingResultToJson(this);
}

PathFindingResult computePathFinding(AppStateData appState) {
  final startRobot = Robot(
    l1: appState.l1,
    l2: appState.l2,
    x: appState.x,
    y: appState.y,
  );

  final endRobot = Robot(
    l1: appState.l1,
    l2: appState.l2,
    x: appState.endX,
    y: appState.endY,
  );

  final startA1 =
      normalizedDegree(radianToDegree(atan2(startRobot.y1!, startRobot.x1!)));
  final startA2 =
      normalizedDegree(radianToDegree(atan2(startRobot.y, startRobot.x)));

  final endA1 =
      normalizedDegree(radianToDegree(atan2(endRobot.y1!, endRobot.x1!)));
  final endA2 = normalizedDegree(radianToDegree(atan2(endRobot.y, endRobot.x)));

  final distance = List<List<int>>.generate(
    360,
    (_) => List.generate(360, (_) => 0),
  );

  final visited = List<List<bool>>.generate(
    360,
    (_) => List.generate(360, (_) => false),
  );

  distance[startA1][startA2] = 0;
  visited[startA1][startA2] = true;
  final q = Queue<(int, int)>()..add((startA1, startA2));

  while (q.isNotEmpty) {
    final p = q.removeFirst();
    final d = distance[p.$1][p.$2];
    final neighbours = [
      (normalizedDegree(p.$1 - 1), normalizedDegree(p.$2)),
      (normalizedDegree(p.$1 + 1), normalizedDegree(p.$2)),
      (normalizedDegree(p.$1), normalizedDegree(p.$2 - 1)),
      (normalizedDegree(p.$1), normalizedDegree(p.$2 + 1)),
    ];

    for (final n in neighbours) {
      if (!visited[n.$1][n.$2]) {
        visited[n.$1][n.$2] = true;
        distance[n.$1][n.$2] = d + 1;
        q.add(n);
      }
    }
  }

  final pixels = Uint8List(360 * 360 * 4);
  for (var i = 0; i < pixels.length; i++) {
    if (i % 4 == 3) {
      pixels[i] = 255;
    } else if (i % 4 == 1) {
      final a = i ~/ 4 ~/ 360;
      final b = (i ~/ 4) % 360;
      pixels[i] = (((distance[a][b] / 360) * (-1) + 1) * 255).toInt();
    } else {
      pixels[i] = 0;
    }
  }
  return PathFindingResult(pixels);
}

int radianToDegree(double r) {
  return (r / 2 / 3.14 * 360).toInt();
}

int normalizedDegree(int d) {
  if (d < 0) {
    return d + 360;
  } else if (d >= 360) {
    return d - 360;
  } else {
    return d;
  }
}
