import 'package:mobx/mobx.dart';

part 'app_state.g.dart';

class AppState = AppStateBase with _$AppState;

abstract class AppStateBase with Store {
  @observable
  double l1 = 0.3;
  @observable
  double l2 = 0.5;

  @action
  void setL1(double l1) {
    this.l1 = l1;
  }

  @action
  void setL2(double l2) {
    this.l2 = l2;
  }
}
