import 'package:flutter/material.dart';

class CheckBox extends StatelessWidget {
  const CheckBox({super.key, required this.onChanged, required this.value});
  final ValueChanged<bool?> onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.amber,
      onChanged: onChanged,
      title: const Text("remember me"),
      value: value,
    );
  }
}
