import 'package:flutter/material.dart';
import 'package:frontend/features/home_page/widgets/participant_dashboard.dart';
import 'package:frontend/features/home_page/widgets/participant_dashboard_progress.dart';
import 'package:frontend/features/home_page/widgets/start_stop_race.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          RaceTimerWidget(),
          const SizedBox(height: 20),
          ParticipantDashboard(),
          ParticipantDashboardProgress(),
        ],
      ),
    );
  }
}
