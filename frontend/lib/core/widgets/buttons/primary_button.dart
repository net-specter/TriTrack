import 'package:flutter/material.dart';
import 'package:frontend/core/theme/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double fontSize;
  final Color? backgroundColor;
  final Icon? icon;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.backgroundColor,
    this.fontSize = 16,
    this.icon,
  });

  void _onPressed() {
    if (onPressed != null) {
      onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: backgroundColor ?? TriColors.primary,
      ),
      onPressed: _onPressed,
      icon: icon,
      label: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
