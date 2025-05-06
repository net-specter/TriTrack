import 'package:flutter/material.dart';
import 'package:frontend/core/theme/text_styles.dart';
import '../../home_page/controllers/start_stop_race_controller.dart';

class Timecount extends StatefulWidget {
  const Timecount({super.key});

  @override
  State<Timecount> createState() => _TimecountState();
}

class _TimecountState extends State<Timecount> {
  final StartStopRaceController _controller = StartStopRaceController();

  @override
  void initState() {
    super.initState();
    _controller.listenToRaceUpdates(() {
      setState(() {}); // Update the UI whenever the race data changes
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _controller.formatTime(_controller.milliseconds),
      style: TriTextStyles.headline,
    );
  }
}
