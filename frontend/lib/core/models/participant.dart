import 'package:cloud_firestore/cloud_firestore.dart';

class Participant {
  final String id;
  final double bibNumber;
  final String name;
  final String category;
  final Timestamp createdAt;

  Participant({
    required this.id,
    required this.name,
    required this.category,
    required this.bibNumber,
  }) : createdAt = Timestamp.now();
}

enum Segment { swimming, running, biking }

class CheckPointLog {
  final String id;
  final Segment? segmentType;
  final DateTime? timeLog;
  final String? duration;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  CheckPointLog({
    required this.id,
    this.segmentType,
    this.timeLog,
    this.duration,
  }) : createdAt = Timestamp.now(),
       updatedAt = Timestamp.now();
}
