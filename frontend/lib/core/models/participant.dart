import 'package:cloud_firestore/cloud_firestore.dart';

class Participant {
  final String id;
  final double bibNumber;
  final String name;
  final String category;
  final DateTime? swimmingTime;
  final String? swimmingDuration;
  final DateTime? cyclingTime;
  final String? cyclingDuration;
  final DateTime? runningTime;
  final String? runningDuration;
  final String? rank;
  final String? finalDuration;
  double rankValue = 0;
  final Timestamp createdAt;

  Participant({
    required this.id,
    required this.name,
    required this.category,
    required this.bibNumber,
    this.swimmingTime,
    this.swimmingDuration,
    this.cyclingTime,
    this.cyclingDuration,
    this.runningTime,
    this.runningDuration,
    this.rank,
    this.finalDuration,
    this.rankValue = 0,
  }) : createdAt = Timestamp.now();
}

// class CheckPointLog {
//   final String id;
//   final String participantId;
//   final String? segmentType;
//   final DateTime? timeLog;
//   final String? duration;
//   final Timestamp createdAt;
//   final Timestamp updatedAt;

//   CheckPointLog({
//     required this.id,
//     required this.participantId,
//     this.segmentType,
//     this.timeLog,
//     this.duration,
//   }) : createdAt = Timestamp.now(),
//        updatedAt = Timestamp.now();
// }
