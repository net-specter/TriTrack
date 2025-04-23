import 'package:flutter/material.dart';

import '../../../core/theme/text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('00:00:00', style: TriTextStyles.headline),
          Text('Participants Dashboard', style: TriTextStyles.title),
        ],
      ),
    );
  }
}
