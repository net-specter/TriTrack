import 'package:flutter/material.dart';
import 'package:frontend/core/theme/text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home Page',
        style: TriTextStyles.body.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
