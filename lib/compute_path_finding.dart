import 'dart:collection';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kinematic_chain_path_finding/app_state.dart';
import 'package:kinematic_chain_path_finding/robot.dart';

part 'compute_path_finding.g.dart';

@JsonSerializable()
class AppStateData {
  AppStateData(
    this.l1,
    this.l2,
    this.x,
    this.y,
    this.endX,
    this.endY,
    this.obstacles,
    this.positionType,
    this.endPositionType,
  );

  factory AppStateData.fromJson(Map<String, dynamic> json) =>
      _$AppStateDataFromJson(json);

  final double l1;
  final double l2;

  final double x;
  final double y;
  final RobotPositionType positionType;

  final double endX;
  final double endY;
  final RobotPositionType endPositionType;

  final List<Obstacle> obstacles;

  Map<String, dynamic> toJson() => _$AppStateDataToJson(this);
}

@JsonSerializable()
class PathFindingResult {
  PathFindingResult(this.pixels, this.path);

  factory PathFindingResult.fromJson(Map<String, dynamic> json) =>
      _$PathFindingResultFromJson(json);

  final List<int> pixels;
  final List<(int, int)>? path;

  Map<String, dynamic> toJson() => _$PathFindingResultToJson(this);
}

PathFindingResult computePathFinding(AppStateData appState) {
  final startRobot = Robot.fromInverse(
    l1: appState.l1,
    l2: appState.l2,
    x: appState.x,
    y: appState.y,
    obstacles: appState.obstacles,
    positionType: appState.positionType,
  );

  final endRobot = Robot.fromInverse(
    l1: appState.l1,
    l2: appState.l2,
    x: appState.endX,
    y: appState.endY,
    obstacles: appState.obstacles,
    positionType: appState.endPositionType,
  );

  final startA1 = normalizedDegree(
    radianToDegree(
      atan2(
        startRobot.y1!,
        startRobot.x1!,
      ),
    ),
  );
  final startA2 = normalizedDegree(
    radianToDegree(
      atan2(
        startRobot.y - startRobot.y1!,
        startRobot.x - startRobot.x1!,
      ),
    ),
  );

  final endA1 = normalizedDegree(
    radianToDegree(
      atan2(
        endRobot.y1!,
        endRobot.x1!,
      ),
    ),
  );
  final endA2 = normalizedDegree(
    radianToDegree(
      atan2(
        endRobot.y - endRobot.y1!,
        endRobot.x - endRobot.x1!,
      ),
    ),
  );

  final distance = List<List<int>>.generate(
    360,
    (_) => List.generate(360, (_) => 0),
  );

  final visited = List<List<bool>>.generate(
    360,
    (_) => List.generate(360, (_) => false),
  );

  for (var i = 0; i < 360; i++) {
    for (var j = 0; j < 360; j++) {
      final testRobot = Robot.fromAngles(
        appState.l1,
        appState.l2,
        i * 2 * 3.14 / 360,
        j * 2 * 3.14 / 360,
        appState.obstacles,
      );

      if (testRobot.x1 == null) {
        distance[i][j] = -1;
        visited[i][j] = true;
      }
    }
  }
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

  var fd = distance[endA1][endA2];
  final path = List<(int, int)>.empty(growable: true)..add((endA1, endA2));
  var current = (endA1, endA2);
  while (fd > 0) {
    final neighbours = [
      (normalizedDegree(current.$1 - 1), normalizedDegree(current.$2)),
      (normalizedDegree(current.$1 + 1), normalizedDegree(current.$2)),
      (normalizedDegree(current.$1), normalizedDegree(current.$2 - 1)),
      (normalizedDegree(current.$1), normalizedDegree(current.$2 + 1)),
    ];

    for (final n in neighbours) {
      if (distance[n.$1][n.$2] == fd - 1) {
        path.add(n);
        fd = fd - 1;
        current = n;
        break;
      }
    }
  }

  path.add((startA1, startA2));

  final pixels = Uint8List(360 * 360 * 4);
  for (var i = 0; i < pixels.length; i++) {
    final a = i ~/ 4 ~/ 360;
    final b = (i ~/ 4) % 360;
    if (i % 4 == 3) {
      pixels[i] = 255;
    } else if (i % 4 == 1 && distance[a][b] != -1 && visited[a][b]) {
      pixels[i] = (clampDouble(
                (distance[a][b] / 720) * (-1) + 1,
                0,
                1,
              ) *
              255)
          .toInt();
    } else if (i % 4 == 0 && distance[a][b] == -1) {
      pixels[i] = 255;
    } else {
      pixels[i] = 0;
    }
  }
  return PathFindingResult(pixels, path);
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
