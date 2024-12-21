import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kinematic_chain_path_finding/compute_path_finding.dart';
import 'package:kinematic_chain_path_finding/robot.dart';
import 'package:mobx/mobx.dart';

part 'app_state.g.dart';

class AppState = AppStateBase with _$AppState;

abstract class AppStateBase with Store {
  @observable
  double l1 = 0.3;
  @observable
  double l2 = 0.5;

  @observable
  double x = 0.5;
  @observable
  double y = 0;
  @observable
  RobotPositionType positionType = RobotPositionType.basic;

  @observable
  double endX = -0.5;
  @observable
  double endY = 0;
  @observable
  RobotPositionType endPositionType = RobotPositionType.basic;

  @observable
  bool floodFillIsBeingComputed = false;
  @observable
  ui.Image? image;

  @observable
  Robot startRobot = Robot.fromInverse(
    l1: 0.3,
    l2: 0.5,
    x: 0.5,
    y: 0,
    obstacles: List.empty(),
  );
  @observable
  Robot endRobot = Robot.fromInverse(
    l1: 0.3,
    l2: 0.5,
    x: -0.5,
    y: 0,
    obstacles: List.empty(),
  );

  List<(int, int)>? path;

  @observable
  List<Obstacle> obstacles = List.empty(growable: true);

  @action
  void setL1(double l1) {
    this.l1 = l1;
    startRobot = Robot.fromInverse(
      l1: l1,
      l2: l2,
      x: x,
      y: y,
      obstacles: obstacles,
    );
    endRobot = Robot.fromInverse(
      l1: l1,
      l2: l2,
      x: endX,
      y: endY,
      obstacles: obstacles,
    );
  }

  @action
  void setL2(double l2) {
    this.l2 = l2;
    startRobot = Robot.fromInverse(
      l1: l1,
      l2: l2,
      x: x,
      y: y,
      obstacles: obstacles,
    );
    endRobot = Robot.fromInverse(
      l1: l1,
      l2: l2,
      x: endX,
      y: endY,
      obstacles: obstacles,
    );
  }

  @action
  void setX(double x) {
    this.x = x;
    startRobot =
        Robot.fromInverse(l1: l1, l2: l2, x: x, y: y, obstacles: obstacles);
  }

  @action
  void setY(double y) {
    this.y = y;
    startRobot =
        Robot.fromInverse(l1: l1, l2: l2, x: x, y: y, obstacles: obstacles);
  }

  @action
  void setPositionType(RobotPositionType positionType) {
    this.positionType = positionType;
  }

  @action
  void setEndX(double x) {
    endX = x;
    endRobot = Robot.fromInverse(
      l1: l1,
      l2: l2,
      x: endX,
      y: endY,
      obstacles: obstacles,
    );
  }

  @action
  void setEndY(double y) {
    endY = y;
    endRobot = Robot.fromInverse(
      l1: l1,
      l2: l2,
      x: endX,
      y: endY,
      obstacles: obstacles,
    );
  }

  @action
  void setEndPositionType(RobotPositionType positionType) {
    endPositionType = positionType;
  }

  @action
  Future<void> computeFloodFill() async {
    if (floodFillIsBeingComputed) {
      return;
    }

    floodFillIsBeingComputed = true;
    final pfResult = await compute(
      computePathFinding,
      AppStateData(
        l1,
        l2,
        x,
        y,
        endX,
        endY,
        obstacles,
      ),
    );
    final completer = Completer<ui.Image>();
    ui.decodeImageFromPixels(
      Uint8List.fromList(pfResult.pixels),
      360,
      360,
      ui.PixelFormat.rgba8888,
      completer.complete,
    );
    image = await completer.future;
    path = pfResult.path;
    floodFillIsBeingComputed = false;
  }

  @action
  void updateAnimation(double v) {
    if (path == null) {
      return;
    }

    final index = (v * (path!.length - 1)).toInt();

    startRobot = Robot.fromAngles(
      l1,
      l2,
      path![index].$1.toDouble() * 2 * 3.14 / 360,
      path![index].$2.toDouble() * 2 * 3.14 / 360,
      obstacles,
    );
  }

  @action
  void addObstacle(Obstacle obstacle) {
    obstacles.add(obstacle);
    startRobot = Robot.fromInverse(
      l1: l1,
      l2: l2,
      x: x,
      y: y,
      obstacles: obstacles,
    );
    endRobot = Robot.fromInverse(
      l1: l1,
      l2: l2,
      x: endX,
      y: endY,
      obstacles: obstacles,
    );
  }
}

enum RobotPositionType {
  basic,
  alternative,
}

@JsonSerializable()
class Obstacle {
  Obstacle(this.startX, this.startY, this.endX, this.endY);

  factory Obstacle.fromJson(Map<String, dynamic> json) =>
      _$ObstacleFromJson(json);

  double startX;
  double startY;
  double endX;
  double endY;

  Map<String, dynamic> toJson() => _$ObstacleToJson(this);
}
