import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.subtitle,
    required this.text,
    required this.onTap,
    required this.trailing,
  });

  final Widget subtitle;
  final Widget text;
  final void Function() onTap;

  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: text,
        subtitle: subtitle,
        trailing: trailing,
      ),
    );
  }
}
