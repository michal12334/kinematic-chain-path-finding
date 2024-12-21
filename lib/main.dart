import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kinematic_chain_path_finding/app_state.dart';
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

class Scene extends StatefulWidget {
  const Scene({
    super.key,
    required AppState appState,
  }) : _appState = appState;

  final AppState _appState;

  @override
  State<Scene> createState() => _SceneState();
}

class _SceneState extends State<Scene> {
  final FocusNode _focusNode = FocusNode();
  double _x = 0;
  double _y = 0;

  double? _cx;
  double? _cy;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.keyC) {
          setState(() {
            _cx = _x;
            _cy = _y;
          });
        } else if (event is KeyUpEvent &&
            event.logicalKey == LogicalKeyboardKey.keyC) {
          if (_cx != null) {
            widget._appState.addObstacle(Obstacle(_x, _y, _cx!, _cy!));
            setState(() {
              _cx = _cy = null;
            });
          }
        }

        return KeyEventResult.handled;
      },
      child: Listener(
        onPointerDown: (event) {
          if (event.buttons == kPrimaryMouseButton) {
            widget._appState
              ..setX(_x)
              ..setY(_y);
          } else if (event.buttons == kSecondaryMouseButton) {
            widget._appState
              ..setEndX(_x)
              ..setEndY(_y);
          }
        },
        onPointerHover: (event) {
          setState(() {
            _x = event.localPosition.dx / context.size!.width * 2 - 1;
            _y = event.localPosition.dy / context.size!.height * (-2) + 1;
          });
        },
        onPointerMove: (event) {
          setState(() {
            _x = event.localPosition.dx / context.size!.width * 2 - 1;
            _y = event.localPosition.dy / context.size!.height * (-2) + 1;
          });
        },
        child: Observer(
          builder: (_) => CustomPaint(
            painter: ScenePainter(
              robot: widget._appState.startRobot,
              endRobot: widget._appState.endRobot,
              obstacles: widget._appState.obstacles,
              additionalObstacle:
                  _cx == null ? null : Obstacle(_cx!, _cy!, _x, _y),
            ),
          ),
        ),
      ),
    );
  }
}
