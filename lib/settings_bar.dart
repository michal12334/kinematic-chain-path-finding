import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kinematic_chain_path_finding/app_state.dart';
import 'package:kinematic_chain_path_finding/header_text.dart';

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
      body: ListView(
        children: [
          const HeaderText('Robot parameters'),
          Observer(
            builder: (_) => DragValue(
              text: 'l1',
              value: appState.l1,
              onChanged: appState.setL1,
              min: 0.1,
            ),
          ),
          Observer(
            builder: (_) => DragValue(
              text: 'l2',
              value: appState.l2,
              onChanged: appState.setL2,
              min: 0.1,
            ),
          ),
          const HeaderText('Start position'),
          Observer(
            builder: (_) => DragValue(
              text: 'x',
              value: appState.x,
              onChanged: appState.setX,
              min: -1,
            ),
          ),
          Observer(
            builder: (_) => DragValue(
              text: 'y',
              value: appState.y,
              onChanged: appState.setY,
              min: -1,
            ),
          ),
          const HeaderText('End position'),
          Observer(
            builder: (_) => DragValue(
              text: 'x',
              value: appState.endX,
              onChanged: appState.setEndX,
              min: -1,
            ),
          ),
          Observer(
            builder: (_) => DragValue(
              text: 'y',
              value: appState.endY,
              onChanged: appState.setEndY,
              min: -1,
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.post_add_outlined),
            label: 'asdf',
          ),
          NavigationDestination(
            icon: Icon(Icons.aspect_ratio_rounded),
            label: 'qwer',
          ),
        ],
      ),
    );
  }
}

class DragValue extends StatelessWidget {
  const DragValue({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
  });

  final String text;
  final double value;
  final void Function(double) onChanged;
  final double min;
  final double max;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(text),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
        ),
        Text(value.toStringAsFixed(2)),
      ],
    );
  }
}
