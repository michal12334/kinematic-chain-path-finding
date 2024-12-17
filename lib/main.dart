import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kinematic_chain_path_finding/app_state.dart';
import 'package:kinematic_chain_path_finding/robot.dart';
import 'package:kinematic_chain_path_finding/scene_painter.dart';
import 'package:kinematic_chain_path_finding/settings_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kinematic chain path finding',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AppState _appState = AppState();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 270,
          child: SettingsBar(
            appState: _appState,
          ),
        ),
        Flexible(
          flex: 5,
          child: SizedBox.expand(
            child: Scene(appState: _appState),
          ),
        ),
      ],
    );
  }
}

class Scene extends StatelessWidget {
  const Scene({
    super.key,
    required AppState appState,
  }) : _appState = appState;

  final AppState _appState;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        final x = event.localPosition.dx / context.size!.width * 2 - 1;
        final y = event.localPosition.dy / context.size!.height * (-2) + 1;

        if (event.buttons == kPrimaryMouseButton) {
          _appState
            ..setX(x)
            ..setY(y);
        }
      },
      child: Observer(
        builder: (_) => CustomPaint(
          painter: ScenePainter(
            robot: Robot(
              l1: _appState.l1,
              l2: _appState.l2,
              x: _appState.x,
              y: _appState.y,
            ),
          ),
        ),
      ),
    );
  }
}
