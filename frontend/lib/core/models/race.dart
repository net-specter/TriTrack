import 'package:cloud_firestore/cloud_firestore.dart';

class Race {
  String id;
  String title;
  String status;
  DateTime? startTime;
  DateTime? endTime;
  Timestamp createdAt;

  Race({
    required this.id,
    required this.title,
    required this.status,
    this.startTime,
    this.endTime,
    Timestamp? createdAt,
  }) : createdAt = createdAt ?? Timestamp.now();
}
