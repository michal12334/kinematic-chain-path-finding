import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kinematic_chain_path_finding/app_state.dart';
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
            child: Observer(
              builder: (_) => CustomPaint(
                painter:
                    MyPainter(robot: Robot(l1: _appState.l1, l2: _appState.l2)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  MyPainter({super.repaint, required Robot robot}) : _robot = robot;

  final Robot _robot;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4;

    final c0 = _getNormalizedCoords(0, 0, size);
    final c1 = _getNormalizedCoords(_robot.l1, 0, size);
    final c2 = _getNormalizedCoords(_robot.l1, _robot.l2, size);

    canvas
      ..drawLine(Offset(c0.$1, c0.$2), Offset(c1.$1, c1.$2), paint)
      ..drawLine(Offset(c1.$1, c1.$2), Offset(c2.$1, c2.$2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  (double x, double y) _getNormalizedCoords(double x, double y, Size size) {
    final rx = (x + 1) / 2 * size.width;
    final ry = (-y + 1) / 2 * size.height;
    return (rx, ry);
  }
}

class Robot {
  Robot({required this.l1, required this.l2});

  final double l1;
  final double l2;
}
