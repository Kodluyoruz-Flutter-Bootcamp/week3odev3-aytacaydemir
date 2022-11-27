import 'package:flutter/material.dart';

class TxtField extends StatelessWidget {
  const TxtField(
      {super.key,
      required this.txt,
      required this.controller,
      required this.obsecureText});
  final String txt;
  final TextEditingController controller;
  final bool obsecureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obsecureText,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: txt,
      ),
    );
  }
}
