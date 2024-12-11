import 'package:flutter/material.dart';

class SettingsBar extends StatefulWidget {
  const SettingsBar({
    super.key,
  });

  @override
  State<SettingsBar> createState() => _SettingsBarState();
}

class _SettingsBarState extends State<SettingsBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
