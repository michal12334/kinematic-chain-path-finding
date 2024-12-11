import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  const HeaderText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20),
      textAlign: TextAlign.center,
    );
  }
}
