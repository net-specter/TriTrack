import 'package:flutter/material.dart';
import 'package:frontend/core/models/participant.dart';
import 'package:frontend/core/providers/participant_provider.dart';
import 'package:provider/provider.dart';

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
              return Card(
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
