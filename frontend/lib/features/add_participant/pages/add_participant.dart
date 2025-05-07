import 'package:flutter/material.dart';
import 'package:frontend/core/models/participant.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/theme/text_styles.dart';
import 'package:frontend/core/widgets/buttons/primary_button.dart';
import 'package:frontend/features/add_participant/widgets/list_partcipant.dart';
import 'package:frontend/features/add_participant/widgets/popup_add.dart';

import '../../../core/theme/space.dart';

class AddParticipant extends StatelessWidget {
  const AddParticipant({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Center(child: Text('Manage Participants', style: TriTextStyles.title)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PrimaryButton(
              label: "Add Participant",
              icon: const Icon(Icons.add_circle_outline, color: Colors.white),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return const AddParticipantModal(
                      titlePopup: "Add Participant",
                    );
                  },
                );
              },
            ),
            const SizedBox(width: 20),
          ],
        ),
        const SizedBox(height: 20),
        const Expanded(child: ListPartcipant()),
      ],
    );
  }
}

class AddParticipantModal extends StatelessWidget {
  final String titlePopup;
  final Participant? participant;
  const AddParticipantModal({
    super.key,
    required this.titlePopup,
    this.participant,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        decoration: BoxDecoration(
          color: TriColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 5),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ModalHeader(title: titlePopup),
            Expanded(
              child: AddParticipantForm(
                participant: participant,
                title: "Add Participants",
                isEdit: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModalHeader extends StatelessWidget {
  final String title;

  const ModalHeader({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Textpacings.l),
      child: Text(
        title,
        style: TriTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    );
  }
}
