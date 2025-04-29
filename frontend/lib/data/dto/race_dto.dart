import 'package:cloud_firestore/cloud_firestore.dart';

enum RaceStatus { notStarted, inProgress, finished }

class RaceDTO {
  String id;
  String title;
  String status;
  DateTime? startTime;
  DateTime? endTime;
  Timestamp createdAt;

  RaceDTO({
    required this.id,
    required this.title,
    required this.status,
    required this.createdAt,
    this.startTime,
    this.endTime,
  });

  factory RaceDTO.fromFirestore(String id, Map<String, dynamic> json) {
    return RaceDTO(
      id: id,
      title: json['title'] ?? '',
      status: json['status'] ?? 'not_started',
      startTime:
          json['start_time'] != null
              ? (json['start_time'] as Timestamp).toDate()
              : null,
      endTime:
          json['end_time'] != null
              ? (json['end_time'] as Timestamp).toDate()
              : null,
      createdAt: json['created_at'] as Timestamp,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'status': status,
      'start_time': startTime != null ? Timestamp.fromDate(startTime!) : null,
      'end_time': endTime != null ? Timestamp.fromDate(endTime!) : null,
      'created_at': createdAt,
    };
  }
}
