import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/participant_provider.dart';
import '../../../core/models/participant.dart';
import '../../../core/theme/colors.dart';

class TableParticipant extends StatefulWidget {
  const TableParticipant({super.key});

  @override
  State<TableParticipant> createState() => _TableParticipantState();
}

class _TableParticipantState extends State<TableParticipant> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final participantProvider = Provider.of<ParticipantProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Search by Name or BIB',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value.toLowerCase();
              });
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: StreamBuilder<List<Participant>>(
                  stream: participantProvider.getParticipantsRank(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No participants available.'),
                      );
                    }
                    final participants =
                        snapshot.data!
                            .where(
                              (participant) =>
                                  participant.name.toLowerCase().contains(
                                    _searchQuery,
                                  ) ||
                                  participant.bibNumber.toString().contains(
                                    _searchQuery,
                                  ),
                            )
                            .toList();

                    return DataTable(
                      headingRowColor: WidgetStateColor.resolveWith(
                        (states) => Colors.grey.shade200,
                      ),
                      columns: const [
                        DataColumn(label: Text('Rank')),
                        DataColumn(label: Text('BIB')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Swimming')),
                        DataColumn(label: Text('Cycling')),
                        DataColumn(label: Text('Running')),
                        DataColumn(label: Text('Duration')),
                      ],
                      rows:
                          participants.map((participant) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    participant.rank ?? '-',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: _getRankColor(participant.rank),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(participant.bibNumber.toString()),
                                ),
                                DataCell(
                                  Text(
                                    participant.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(participant.swimmingDuration ?? '-'),
                                ),
                                DataCell(
                                  Text(participant.cyclingDuration ?? '-'),
                                ),
                                DataCell(
                                  Text(participant.runningDuration ?? '-'),
                                ),
                                DataCell(
                                  Text(
                                    participant.finalDuration ?? '-',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getRankColor(String? rank) {
    if (rank == null) return Colors.black;
    if (rank.endsWith('st')) return TriColors.gold;
    if (rank.endsWith('nd')) return TriColors.silver;
    if (rank.endsWith('rd')) return TriColors.brown;
    return Colors.black;
  }
}
