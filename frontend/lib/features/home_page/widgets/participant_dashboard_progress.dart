import 'package:flutter/material.dart';
import 'package:frontend/core/models/participant.dart';
import 'package:frontend/core/theme/text_styles.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/participant_provider.dart';

class ParticipantDashboardProgress extends StatelessWidget {
  const ParticipantDashboardProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final participantProvider = Provider.of<ParticipantProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 15),
      child: Column(
        children: [
          FutureBuilder<List<Participant>>(
            future: participantProvider.getParticipentSwimmingComplete(),
            builder: (context, swimmingSnapshot) {
              if (swimmingSnapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (swimmingSnapshot.hasError) {
                return Text('Error: ${swimmingSnapshot.error}');
              }

              final completedSwimming = swimmingSnapshot.data?.length ?? 0;
              final totalSwimming = participantProvider.participants.length;

              return SegmentProgressWidget(
                title: "Swimming Segment Progress",
                completed: completedSwimming,
                total: totalSwimming,
              );
            },
          ),
          FutureBuilder<List<Participant>>(
            future: participantProvider.getParticipentCyclingComplete(),
            builder: (context, cyclingSnapshot) {
              if (cyclingSnapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (cyclingSnapshot.hasError) {
                return Text('Error: ${cyclingSnapshot.error}');
              }

              final completedCycling = cyclingSnapshot.data?.length ?? 0;
              final totalCycling = participantProvider.participants.length;

              return SegmentProgressWidget(
                title: "Cycling Segment Progress",
                completed: completedCycling,
                total: totalCycling,
              );
            },
          ),
          FutureBuilder<List<Participant>>(
            future: participantProvider.getParticipentRunningComplete(),
            builder: (context, runningSnapshot) {
              if (runningSnapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (runningSnapshot.hasError) {
                return Text('Error: ${runningSnapshot.error}');
              }

              final completedRunning = runningSnapshot.data?.length ?? 0;
              final totalRunning = participantProvider.participants.length;

              return SegmentProgressWidget(
                title: "Running Segment Progress",
                completed: completedRunning,
                total: totalRunning,
              );
            },
          ),
        ],
      ),
    );
  }
}

class SegmentProgressWidget extends StatelessWidget {
  final String title;
  final int completed;
  final int total;

  const SegmentProgressWidget({
    super.key,
    required this.title,
    required this.completed,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    double progress = total > 0 ? completed / total : 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TriTextStyles.body),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 12,
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              '$completed/$total Completed',
              style: TriTextStyles.captionSmall,
            ),
          ),
        ],
      ),
    );
  }
}
