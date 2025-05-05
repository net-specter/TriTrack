import 'package:flutter/material.dart';
import 'package:frontend/features/home_page/widgets/start_stop_race.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const RaceTimerWidget(), // Add the race timer widget
        ],
      ),
    );
  }
}
