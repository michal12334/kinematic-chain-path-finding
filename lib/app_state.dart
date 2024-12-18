import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
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
  double endX = -0.5;
  @observable
  double endY = 0;

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
  void setEndX(double x) {
    endX = x;
  }

  @action
  void setEndY(double y) {
    endY = y;
  }

  @action
  Future<void> computeFloodFill() async {
    if (floodFillIsBeingComputed) {
      return;
    }

    floodFillIsBeingComputed = true;
    final pixels = await compute(_computeFloodFill, AppStateData());
    final completer = Completer<ui.Image>();
    ui.decodeImageFromPixels(
      pixels,
      360,
      360,
      ui.PixelFormat.rgba8888,
      completer.complete,
    );
    image = await completer.future;
    floodFillIsBeingComputed = false;
  }
}

Uint8List _computeFloodFill(AppStateData c) {
  final result = Uint8List(360 * 360 * 4);
  for (var i = 0; i < result.length; i++) {
    if (i % 4 == 3) {
      result[i] = 255;
    } else {
      result[i] = i % 255;
    }
  }
  return result;
}

@JsonSerializable()
class AppStateData {
  AppStateData();

  factory AppStateData.fromJson(Map<String, dynamic> json) =>
      _$AppStateDataFromJson(json);

  double x = 0.5;

  Map<String, dynamic> toJson() => _$AppStateDataToJson(this);
}
