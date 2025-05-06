import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

enum RaceStatus { notStarted, active, finished }

class StartStopRaceController {
  Timer? _timer;
  int _milliseconds = 0;
  RaceStatus _status = RaceStatus.notStarted;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _raceId = 'pxs4oGoSCo46kvMk0lNN'; // Use the provided race ID
  late StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>
  _raceSubscription;

  int get milliseconds => _milliseconds;
  RaceStatus get status => _status;

  void listenToRaceUpdates(void Function() onUpdate) {
    // Listen to real-time updates for the race document
    _raceSubscription = _firestore
        .collection('race')
        .doc(_raceId)
        .snapshots()
        .listen((snapshot) {
          if (snapshot.exists) {
            final data = snapshot.data()!;
            final status = data['status'] as String?;
            final startTime = (data['start_time'] as Timestamp?)?.toDate();
            final endTime = (data['end_time'] as Timestamp?)?.toDate();

            if (status == 'in_progress' && startTime != null) {
              _status = RaceStatus.active;
              _milliseconds =
                  DateTime.now().difference(startTime).inMilliseconds;
              _startTimerInternal(onUpdate);
            } else if (status == 'finished' &&
                startTime != null &&
                endTime != null) {
              _status = RaceStatus.finished;
              _milliseconds = endTime.difference(startTime).inMilliseconds;
              _stopTimer();
            } else {
              _status = RaceStatus.notStarted;
              _milliseconds = 0;
              _stopTimer();
            }

            onUpdate(); // Notify the UI to update
          }
        });
  }

  Future<void> startTimer() async {
    if (_status == RaceStatus.notStarted) {
      _milliseconds = 0;

      // Update the race document in Firestore to start the race
      await _firestore.collection('race').doc(_raceId).update({
        'status': 'in_progress',
        'start_time': Timestamp.now(),
      });
    }
  }

  Future<void> endTimer() async {
    _stopTimer();
    _status = RaceStatus.finished;

    // Update the race document in Firestore to end the race
    await _firestore.collection('race').doc(_raceId).update({
      'status': 'finished',
      'end_time': Timestamp.now(),
      'duration': _milliseconds,
    });
  }

  void _startTimerInternal(void Function() onUpdate) {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      _milliseconds += 10;
      onUpdate(); // Notify the UI to update
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  String formatTime(int milliseconds) {
    final duration = Duration(milliseconds: milliseconds);
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    final millis = (duration.inMilliseconds % 1000).toString().padLeft(3, '0');
    return '$hours:$minutes:$seconds.$millis';
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
    _raceSubscription.cancel();
  }
}
