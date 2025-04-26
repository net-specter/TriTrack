import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String title;
  final IconData? icon;
  final double? fontSize;
  const TabItem({
    super.key,
    required this.title,
    this.icon,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) Icon(icon, size: 16),
        if (icon != null) const SizedBox(width: 5),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}
