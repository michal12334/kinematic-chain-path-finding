import 'package:flutter/material.dart';
import 'package:kinematic_chain_path_finding/app_state.dart';
import 'package:kinematic_chain_path_finding/obstacles.dart';
import 'package:kinematic_chain_path_finding/path_finding.dart';
import 'package:kinematic_chain_path_finding/robot_parameters.dart';

class SettingsBar extends StatefulWidget {
  const SettingsBar({super.key, required this.appState});

  final AppState appState;

  @override
  State<SettingsBar> createState() => _SettingsBarState();
}

class _SettingsBarState extends State<SettingsBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appState = widget.appState;

    return Scaffold(
      body: switch (currentPageIndex) {
        0 => RobotParameters(appState: appState),
        1 => PathFinding(appState: appState),
        2 => Obstacles(appState: appState),
        _ => throw Exception(),
      },
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.android_rounded),
            label: 'Robot',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_tree_rounded),
            label: 'Path Finding',
          ),
          NavigationDestination(
            icon: Icon(Icons.window_rounded),
            label: 'Obstacles',
          ),
        ],
      ),
    );
  }
}
