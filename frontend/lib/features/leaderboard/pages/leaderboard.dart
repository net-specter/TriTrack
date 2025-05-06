import 'package:flutter/material.dart';
import 'package:frontend/core/theme/text_styles.dart';
import 'package:frontend/features/leaderboard/widgets/table_participant.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Center(child: Text('Leaderboard', style: TriTextStyles.title)),
        const SizedBox(height: 20),
        Expanded(child: TableParticipant()),
      ],
    );
  }
}
