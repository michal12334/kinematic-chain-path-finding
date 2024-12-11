import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kinematic_chain_path_finding/app_state.dart';

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
      body: Column(
        children: [
          Row(
            children: [
              const Padding(
                  padding: EdgeInsets.only(left: 10.0), child: Text("l1")),
              Observer(
                builder: (_) => Slider(
                  value: appState.l1,
                  min: 0.1,
                  max: 1.0,
                  onChanged: (v) => appState.setL1(v),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Padding(
                  padding: EdgeInsets.only(left: 10.0), child: Text("l2")),
              Observer(
                builder: (_) => Slider(
                  value: appState.l2,
                  min: 0.1,
                  max: 1.0,
                  onChanged: (v) => appState.setL2(v),
                ),
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.post_add_outlined),
              label: "asdf",
            ),
            NavigationDestination(
              icon: Icon(Icons.aspect_ratio_rounded),
              label: "qwer",
            ),
          ]),
    );
  }
}
