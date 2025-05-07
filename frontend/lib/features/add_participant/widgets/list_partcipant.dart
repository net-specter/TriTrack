import 'package:flutter/material.dart';
import 'package:frontend/core/models/participant.dart';
import 'package:frontend/core/providers/participant_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/space.dart';
import '../../../core/theme/text_styles.dart';
import 'popup_add.dart';

class ListPartcipant extends StatelessWidget {
  const ListPartcipant({super.key});

  @override
  Widget build(BuildContext context) {
    final participantProvider = Provider.of<ParticipantProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: StreamBuilder<List<Participant>>(
        stream: participantProvider.getParticipants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No participants available.'));
          }

          final participants = snapshot.data!;

          return ListView.builder(
            physics: const BouncingScrollPhysics(), // Enable smooth scrolling
            itemCount: participants.length,
            itemBuilder: (context, index) {
              final participant = participants[index];
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return AddParticipantModal(
                        id: participant.id,
                        participant: participant,
                        titlePopup: "Edit Participant",
                      );
                    },
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      participant.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          _tag(
                            'BIB ${participant.bibNumber}',
                            Colors.black87,
                            Colors.grey.shade300,
                          ),
                          const SizedBox(width: 8),
                          _tag(
                            participant.category,
                            Colors.blue.shade700,
                            Colors.blue.shade100,
                          ),
                        ],
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        participantProvider.deleteParticipant(participant);
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _tag(String label, Color textColor, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class AddParticipantModal extends StatelessWidget {
  final String titlePopup;
  final String id;
  final Participant participant;
  const AddParticipantModal({
    super.key,
    required this.participant,
    required this.titlePopup,
    required this.id,
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
                title: "Edit Participants",
                participant: participant,
                isEdit: true,
                id: id,
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
