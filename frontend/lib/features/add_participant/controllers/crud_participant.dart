import 'package:flutter/material.dart';

import '../../../core/models/participant.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/providers/participant_provider.dart';

Future<void> createParticipant(
  BuildContext context,
  ParticipantProvider participantProvider,
  Participant participant,
) async {
  try {
    final result = await participantProvider.checkDuplicateBibNumber(
      participant,
    );

    if (result == 'Duplicate') {
      // Show duplicate entry dialog
      await showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Duplicate Entry', style: TriTextStyles.title),
              content: const Text(
                'A participant with this BIB number already exists.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: TriColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    await participantProvider.replaceParticipant(participant);
                    Navigator.of(context).pop(); // Close the dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text('Participant replaced successfully!'),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.check),
                      SizedBox(width: 5),
                      Text(
                        'Replace',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      );
    } else if (result == 'Success') {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          content: Text('Participant added successfully!'),
        ),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          content: Text('An error occurred while adding the participant.'),
        ),
      );
    }
  } catch (e) {
    // Handle unexpected errors
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text('Error: $e'),
      ),
    );
  }
}

Future<void> deleteParticipant(
  BuildContext context,
  Participant p,
  ParticipantProvider participantProvider,
) async {
  final result = await participantProvider.deleteParticipant(p);
  if (result == 'Success') {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('Participant deleted successfully!'),
      ),
    );
  } else {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('An error occurred while deleting the participant.'),
      ),
    );
  }
}

Future<void> editParticipant(
  BuildContext context,
  String participantID,
  Participant updatedParticipant,
  ParticipantProvider participantProvider,
) async {
  try {
    final result = await participantProvider.updateParticipant(
      participantID,
      updatedParticipant,
    );

    if (result == 'Success') {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          content: Text('Participant updated successfully!'),
        ),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          content: Text('An error occurred while updating the participant.'),
        ),
      );
    }
  } catch (e) {
    // Handle unexpected errors
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text('Error: $e'),
      ),
    );
  }
}
