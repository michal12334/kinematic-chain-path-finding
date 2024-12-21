import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kinematic_chain_path_finding/app_state.dart';
import 'package:kinematic_chain_path_finding/drag_value.dart';
import 'package:kinematic_chain_path_finding/header_text.dart';

class RobotParameters extends StatelessWidget {
  const RobotParameters({
    super.key,
    required this.appState,
  });

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const HeaderText('Robot parameters'),
        Observer(
          builder: (_) => DragValue(
            text: 'l1',
            value: appState.l1,
            onChanged: appState.setL1,
            min: 0.1,
            width: 270,
          ),
        ),
        Observer(
          builder: (_) => DragValue(
            text: 'l2',
            value: appState.l2,
            onChanged: appState.setL2,
            min: 0.1,
            width: 270,
          ),
        ),
        const HeaderText('Start position'),
        Observer(
          builder: (_) => DragValue(
            text: 'x',
            value: appState.x,
            onChanged: appState.setX,
            min: -1,
            width: 270,
          ),
        ),
        Observer(
          builder: (_) => DragValue(
            text: 'y',
            value: appState.y,
            onChanged: appState.setY,
            min: -1,
            width: 270,
          ),
        ),
        Observer(
          builder: (_) => Center(
            child: SizedBox(
              width: 200,
              child: Row(
                children: [
                  Checkbox(
                    value:
                        appState.positionType == RobotPositionType.alternative,
                    onChanged: (v) {
                      if (v ?? false) {
                        appState.setPositionType(RobotPositionType.alternative);
                      } else {
                        appState.setPositionType(RobotPositionType.basic);
                      }
                    },
                  ),
                  const Flexible(child: Text('use alternative position')),
                ],
              ),
            ),
          ),
        ),
        const HeaderText('End position'),
        Observer(
          builder: (_) => DragValue(
            text: 'x',
            value: appState.endX,
            onChanged: appState.setEndX,
            min: -1,
            width: 270,
          ),
        ),
        Observer(
          builder: (_) => DragValue(
            text: 'y',
            value: appState.endY,
            onChanged: appState.setEndY,
            min: -1,
            width: 270,
          ),
        ),
        Observer(
          builder: (_) => Center(
            child: SizedBox(
              width: 200,
              child: Row(
                children: [
                  Checkbox(
                    value: appState.endPositionType ==
                        RobotPositionType.alternative,
                    onChanged: (v) {
                      if (v ?? false) {
                        appState
                            .setEndPositionType(RobotPositionType.alternative);
                      } else {
                        appState.setEndPositionType(RobotPositionType.basic);
                      }
                    },
                  ),
                  const Flexible(child: Text('use alternative position')),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
