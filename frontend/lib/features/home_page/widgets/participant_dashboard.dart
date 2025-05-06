import 'package:flutter/material.dart';
import 'package:frontend/core/models/participant.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/theme/text_styles.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/participant_provider.dart';

class ParticipantDashboard extends StatelessWidget {
  const ParticipantDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final participantProvider = Provider.of<ParticipantProvider>(context);

    return FutureBuilder<List<Participant>>(
      future: participantProvider.getParticipantsFinish(),
      builder: (context, finishSnapshot) {
        final participantsFinish = finishSnapshot.data?.length ?? 0;

        return StreamBuilder<Object>(
          stream: participantProvider.getParticipants(),
          builder: (context, snapshot) {
            final participants = [
              {
                'value': '${participantProvider.participants.length}',
                'title': "Total Participants",
              },
              {'value': '$participantsFinish', 'title': "Participants Finish"},
              {
                'value':
                    '${participantProvider.participants.length - participantsFinish}',
                'title': "Participants on Course",
              },
            ];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Participant Dashboard', style: TriTextStyles.title),
                  const SizedBox(height: 20),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.5,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 6,
                        ),
                    itemCount: participants.length,
                    itemBuilder: (context, index) {
                      final participant = participants[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              participant['title'] ?? "null",
                              style: TriTextStyles.bodySmall.copyWith(
                                fontWeight: FontWeight.w900,
                                color: TriColors.greyDark,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              participant['value'] ?? "null",
                              style: TriTextStyles.title,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
