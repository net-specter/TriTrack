import 'package:flutter/material.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/theme/text_styles.dart';
import 'package:frontend/features/home_page/controllers/start-stop-race-controller.dart';

class RaceTimerWidget extends StatefulWidget {
  const RaceTimerWidget({super.key});

  @override
  State<RaceTimerWidget> createState() => _RaceTimerWidgetState();
}

class _RaceTimerWidgetState extends State<RaceTimerWidget> {
  final StartStopRaceController _controller = StartStopRaceController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTimerTick() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 419,
      height: 206,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(157, 178, 206, 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const RaceStatusHeader(),
            const SizedBox(height: 5),
            RaceStatusText(statusText: _controller.getStatusText()),
            const SizedBox(height: 15),
            RaceTimeDisplay(
              time: _controller.formatTime(_controller.milliseconds),
            ),
            const SizedBox(height: 20),
            RaceControlButtons(
              status: _controller.status,
              onStart: () => _controller.startTimer(_onTimerTick),
              onEnd: _controller.endTimer,
            ),
          ],
        ),
      ),
    );
  }
}

class RaceStatusHeader extends StatelessWidget {
  const RaceStatusHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Race Status',
      style: TriTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class RaceStatusText extends StatelessWidget {
  final String statusText;

  const RaceStatusText({required this.statusText, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      statusText,
      style: TriTextStyles.body.copyWith(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class RaceTimeDisplay extends StatelessWidget {
  final String time;

  const RaceTimeDisplay({required this.time, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 392,
      height: 59,

      decoration: BoxDecoration(
        color: const Color(0xFF2E3440),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: TriTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          Text(
            'Race Time',
            style: TriTextStyles.captionSmall.copyWith(
              color: const Color(0xFFFFFFFF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class RaceControlButtons extends StatelessWidget {
  final RaceStatus status;
  final VoidCallback onStart;
  final VoidCallback onEnd;

  const RaceControlButtons({
    required this.status,
    required this.onStart,
    required this.onEnd,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: status != RaceStatus.active ? onStart : null,
          icon: const Icon(Icons.play_arrow),
          label: const Text('Start Race'),
          style: ElevatedButton.styleFrom(
            backgroundColor: TriColors.success,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: TriTextStyles.bodySmall,
          ),
        ),
        const SizedBox(width: 20),
        ElevatedButton.icon(
          onPressed: status == RaceStatus.active ? onEnd : null,
          icon: const Icon(Icons.pause),
          label: const Text('End Race'),
          style: ElevatedButton.styleFrom(
            backgroundColor: TriColors.secondary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: TriTextStyles.bodySmall,
          ),
        ),
      ],
    );
  }
}
