import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:kinematic_chain_path_finding/compute_path_finding.dart';
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

  @action
  void setL1(double l1) {
    this.l1 = l1;
  }

  @action
  void setL2(double l2) {
    this.l2 = l2;
  }

  @action
  void setX(double x) {
    this.x = x;
  }

  @action
  void setY(double y) {
    this.y = y;
  }

  @action
  void setPositionType(RobotPositionType positionType) {
    this.positionType = positionType;
  }

  @action
  void setEndX(double x) {
    endX = x;
  }

  @action
  void setEndY(double y) {
    endY = y;
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
    floodFillIsBeingComputed = false;
  }
}

enum RobotPositionType {
  basic,
  alternative,
}
