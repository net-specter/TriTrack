import 'package:flutter/material.dart';
import 'package:frontend/core/theme/text_styles.dart';
import 'package:lottie/lottie.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Lottie.asset(
            'assets/lottie/no_connection.json',
            width: 200,
            height: 200,
            repeat: true,
            // reverse: true,
          ),
        ),
        Text(
          "No Connection",
          style: TriTextStyles.body.copyWith(fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}
