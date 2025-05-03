import 'package:cloud_firestore/cloud_firestore.dart';

class ParticipantDto {
  final String id;
  final double bibNumber;
  final String name;
  final String category;
  final Timestamp createdAt;

  ParticipantDto({
    required this.id,
    required this.name,
    required this.bibNumber,
    required this.category,
    required this.createdAt,
  });

  factory ParticipantDto.fromJson(String id, Map<String, dynamic> json) {
    return ParticipantDto(
      id: id,
      name: json['name'],
      bibNumber: json['bib_number'],
      category: json['category'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "bib_number": bibNumber,
      "category": category,
      "created_at": createdAt,
    };
  }
}

class CheckPointLogDto {
  final String id;
  final String? segmentType;
  final DateTime? timeLog;
  final String? duration;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  CheckPointLogDto({
    required this.id,
    this.segmentType,
    this.duration,
    this.timeLog,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CheckPointLogDto.fromJson(String id, Map<String, dynamic> json) {
    final timeLogged = json['time_logged'];
    DateTime? parsedTime;

    if (timeLogged is Timestamp) {
      parsedTime = timeLogged.toDate();
    } else if (timeLogged is List &&
        timeLogged.isNotEmpty &&
        timeLogged.first is Timestamp) {
      parsedTime = (timeLogged.first as Timestamp).toDate();
    } else {
      parsedTime = null;
    }

    return CheckPointLogDto(
      id: id,
      segmentType: json['segment_type'],
      timeLog: parsedTime,
      duration: json['duration'],
      createdAt: json['created_at'] ?? Timestamp.now(),
      updatedAt: json['updated_at'] ?? Timestamp.now(),
    );
  }
  factory CheckPointLogDto.empty(String id) {
    final now = Timestamp.now();
    return CheckPointLogDto(
      id: id,
      segmentType: null,
      duration: null,
      timeLog: null,
      createdAt: now,
      updatedAt: now,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "segment_type": segmentType,
      "duration": duration,
      "time_logged": timeLog != null ? Timestamp.fromDate(timeLog!) : null,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}

class CombinedParticipantDto {
  final ParticipantDto participant;
  final CheckPointLogDto checkpointLog;

  CombinedParticipantDto({
    required this.participant,
    required this.checkpointLog,
  });
}
