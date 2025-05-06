import 'package:cloud_firestore/cloud_firestore.dart';

class ParticipantDto {
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
  String? rank;
  String? finalDuration;
  double rankValue;
  final Timestamp createdAt;

  ParticipantDto({
    required this.id,
    required this.name,
    required this.bibNumber,
    required this.category,
    this.swimmingTime,
    this.swimmingDuration,
    this.cyclingTime,
    this.cyclingDuration,
    this.runningTime,
    this.runningDuration,
    this.rank,
    this.finalDuration,
    this.rankValue = 0,
    required this.createdAt,
  });

  factory ParticipantDto.fromJson(String id, Map<String, dynamic> json) {
    return ParticipantDto(
      id: id,
      name: json['name'] ?? '',
      bibNumber: (json['bib_number'] as num).toDouble(),
      category: json['category'] ?? '',
      swimmingTime:
          json['swimming_time'] != null
              ? (json['swimming_time'] as Timestamp).toDate()
              : null,
      swimmingDuration: json['swimming_duration'],
      cyclingTime:
          json['cycling_time'] != null
              ? (json['cycling_time'] as Timestamp).toDate()
              : null,
      cyclingDuration: json['cycling_duration'],
      runningTime:
          json['running_time'] != null
              ? (json['running_time'] as Timestamp).toDate()
              : null,
      runningDuration: json['running_duration'],
      rank: json['rank'],
      finalDuration: json['final_duration'],
      rankValue: json['rank_value'] ?? 0,
      createdAt: json['created_at'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "bib_number": bibNumber,
      "category": category,
      "swimming_time":
          swimmingTime != null ? Timestamp.fromDate(swimmingTime!) : null,
      "swimming_duration": swimmingDuration,
      "cycling_time":
          cyclingTime != null ? Timestamp.fromDate(cyclingTime!) : null,
      "cycling_duration": cyclingDuration,
      "running_time":
          runningTime != null ? Timestamp.fromDate(runningTime!) : null,
      "running_duration": runningDuration,
      "rank": rank,
      "final_duration": finalDuration,
      "rank_value": rankValue,
      "created_at": createdAt,
    };
  }
}
