import 'package:flutter/material.dart';
import 'package:frontend/core/theme/text_styles.dart';
import 'package:frontend/core/widgets/buttons/primary_button.dart';
import 'package:frontend/features/add_participant/widgets/list_partcipant.dart';

class AddParticipant extends StatelessWidget {
  const AddParticipant({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Center(child: Text('Manage Participants', style: TriTextStyles.title)),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PrimaryButton(
              label: "Add Participant",
              icon: Icon(Icons.add_circle_outline, color: Colors.white),
              onPressed: () {},
            ),
            SizedBox(width: 20),
          ],
        ),
        SizedBox(height: 20),
        Expanded(child: ListPartcipant()),
      ],
    );
  }
}
