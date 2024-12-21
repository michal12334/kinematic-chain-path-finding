import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kinematic_chain_path_finding/app_state.dart';
import 'package:kinematic_chain_path_finding/drag_value.dart';
import 'package:kinematic_chain_path_finding/header_text.dart';

class Obstacles extends StatelessWidget {
  const Obstacles({
    super.key,
    required this.appState,
  });

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 4),
          child: Column(
            children: [
              HeaderText('Obstacle $index'),
              DragValue(
                text: 'x0',
                value: appState.obstacles[index].startX,
                onChanged: (v) => appState.updateObstacleStartX(index, v),
                min: -1,
              ),
              DragValue(
                text: 'y0',
                value: appState.obstacles[index].startY,
                onChanged: (v) => appState.updateObstacleStartY(index, v),
                min: -1,
              ),
              DragValue(
                text: 'x1',
                value: appState.obstacles[index].endX,
                onChanged: (v) => appState.updateObstacleEndX(index, v),
                min: -1,
              ),
              DragValue(
                text: 'y1',
                value: appState.obstacles[index].endY,
                onChanged: (v) => appState.updateObstacleEndY(index, v),
                min: -1,
              ),
            ],
          ),
        ),
        itemCount: appState.obstacles.length,
      ),
    );
  }
}
