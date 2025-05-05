import 'dart:async';

enum RaceStatus { notStarted, active, finished }

class StartStopRaceController {
  Timer? _timer;
  int _milliseconds = 0;
  RaceStatus _status = RaceStatus.notStarted;

  int get milliseconds => _milliseconds;
  RaceStatus get status => _status;

  void startTimer(void Function() onTick) {
    if (_status == RaceStatus.notStarted) {
      _milliseconds = 0;
    }

    _status = RaceStatus.active;

    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      _milliseconds += 10;
      onTick(); // Notify the UI to update
    });
  }

  void endTimer() {
    _timer?.cancel();
    _status = RaceStatus.finished;
  }

  String formatTime(int milliseconds) {
    int hours = milliseconds ~/ 3600000;
    int minutes = (milliseconds % 3600000) ~/ 60000;
    int seconds = (milliseconds % 60000) ~/ 1000;
    int millis = (milliseconds % 1000) ~/ 10;

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}:'
        '${millis.toString().padLeft(2, '0')}';
  }

  String getStatusText() {
    switch (_status) {
      case RaceStatus.notStarted:
        return 'Not Started';
      case RaceStatus.active:
        return 'Active';
      case RaceStatus.finished:
        return 'Finished';
    }
  }

  void dispose() {
    _timer?.cancel();
  }
}
