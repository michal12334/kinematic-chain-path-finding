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
}
