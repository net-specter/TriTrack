import 'package:flutter/material.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/theme/text_styles.dart';
import 'package:frontend/core/models/participant.dart';
import 'package:frontend/core/providers/participant_provider.dart';
import 'package:provider/provider.dart';

class TableKeypad extends StatelessWidget {
  final String segmentType;
  const TableKeypad({super.key, required this.segmentType});

  @override
  Widget build(BuildContext context) {
    final participantProvider = Provider.of<ParticipantProvider>(context);
    final participantsStream = participantProvider
        .getParticipantsBySegmentNotNull(segmentType);

    return StreamBuilder<List<Participant>>(
      stream: participantsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error loading participants: ${snapshot.error}"),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No participants available."));
        }

        final participants = snapshot.data!;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              // Table Header
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1.0,
                        ),
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                            'BIB',
                            style: TriTextStyles.body.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text('Name', style: TriTextStyles.body),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text('Duration', style: TriTextStyles.body),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(child: null),
                      ),
                    ],
                  ),
                ],
              ),

              // Table Body
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(1),
                    },
                    children:
                        participants.map((p) {
                          return TableRow(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey[300]!,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Center(
                                  child: Text(
                                    p.bibNumber.toString(),
                                    style: TriTextStyles.bodySmall,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Center(
                                  child: Text(
                                    p.name,
                                    style: TriTextStyles.bodySmall,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Center(
                                  child: Text(
                                    p.swimmingDuration ?? "N/A",
                                    style: TriTextStyles.bodySmall,
                                  ),
                                ),
                              ),
                              Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.refresh,
                                    color: TriColors.primary,
                                    size: 20,
                                  ),
                                  onPressed: () async {
                                    deleteParticipant(
                                      segmentType,
                                      context,
                                      p,
                                      participantProvider,
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void deleteParticipant(
    String segmentType,
    BuildContext context,
    Participant participant,
    ParticipantProvider participantProvider,
  ) async {
    try {
      switch (segmentType) {
        case 'swimming':
          await participantProvider.cardClickRemoveSwimming(participant.id);
          break;
        case 'cycling':
          await participantProvider.cardClickRemoveCycling(participant.id);
          break;
        case 'running':
          await participantProvider.cardClickRemoveSwimming(participant.id);
          break;
      }
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text("Participant undo successfully")));
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text("Error undo participant: $e")));
    }
  }
}
