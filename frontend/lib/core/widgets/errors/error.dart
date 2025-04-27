import 'package:flutter/material.dart';
import 'package:frontend/core/theme/text_styles.dart';
import 'package:lottie/lottie.dart';

class Error extends StatelessWidget {
  final String? errorMessage;
  const Error({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Lottie.asset(
            'assets/lottie/error.json',
            width: 200,
            height: 200,
            repeat: true,
            reverse: true,
          ),
        ),
        Text(
          errorMessage ?? "Failed to load data. Please try again.",
          style: TriTextStyles.body.copyWith(fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}
