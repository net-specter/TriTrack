import 'package:cloud_firestore/cloud_firestore.dart';
import '../dto/participant_dto.dart';
import 'package:rxdart/rxdart.dart';

class ParticipantRepository {
  final CollectionReference _participantsCollection = FirebaseFirestore.instance
      .collection('participants');
  final CollectionReference _checkPointLogCollection = FirebaseFirestore
      .instance
      .collection('checkpoint_logs');
  final CollectionReference _raceCollection = FirebaseFirestore.instance
      .collection('race');

  Stream<List<ParticipantDto>> getParticipants() {
    return _participantsCollection.orderBy("bib_number").snapshots().map((
      snapshot,
    ) {
      return snapshot.docs.map((doc) {
        return ParticipantDto.fromJson(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );
      }).toList();
    });
  }

  Stream<List<CombinedParticipantDto>> getCombinedParticipants() {
    final participantStream = _participantsCollection.snapshots();
    final checkpointLogStream = _checkPointLogCollection.snapshots();

    return Rx.combineLatest2(participantStream, checkpointLogStream, (
      QuerySnapshot participantSnapshot,
      QuerySnapshot checkpointSnapshot,
    ) {
      final checkpointMap = {
        for (var doc in checkpointSnapshot.docs)
          doc.id: CheckPointLogDto.fromJson(
            doc.id,
            doc.data() as Map<String, dynamic>,
          ),
      };

      final combinedList =
          participantSnapshot.docs.map((doc) {
              final participant = ParticipantDto.fromJson(
                doc.id,
                doc.data() as Map<String, dynamic>,
              );

              final checkpoint =
                  checkpointMap[doc.id] ?? CheckPointLogDto.empty(doc.id);

              return CombinedParticipantDto(
                participant: participant,
                checkpointLog: checkpoint,
              );
            }).toList()
            ..sort(
              (a, b) =>
                  a.participant.bibNumber.compareTo(b.participant.bibNumber),
            );

      return combinedList;
    });
  }

  Future<String> checkDuplicateBibNumber(
    ParticipantDto participantDTO,
    CheckPointLogDto checkpointlogDTO,
  ) async {
    try {
      final querySnapshot =
          await _participantsCollection
              .where('bib_number', isEqualTo: participantDTO.bibNumber)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        return 'Duplicate';
      } else {
        return await addParticipant(participantDTO, checkpointlogDTO);
      }
    } catch (e) {
      return 'Error';
    }
  }

  Future<String> replaceParticipant(
    ParticipantDto participantDTO,
    CheckPointLogDto checkPointDTO,
  ) async {
    try {
      final querySnapshot =
          await _participantsCollection
              .where('bib_number', isEqualTo: participantDTO.bibNumber)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        final existingDocId = querySnapshot.docs.first.id;
        await Future.wait([
          _participantsCollection.doc(existingDocId).delete(),
          _checkPointLogCollection.doc(existingDocId).delete(),
          _participantsCollection
              .doc(participantDTO.id)
              .set(participantDTO.toJson()),
          _checkPointLogCollection
              .doc(checkPointDTO.id)
              .set(checkPointDTO.toJson()),
        ]);
      }

      return 'Success';
    } catch (e) {
      return 'Error';
    }
  }

  Future<String> addParticipant(
    ParticipantDto participantDTO,
    CheckPointLogDto checpointlogDTO,
  ) async {
    try {
      final querySnapshot =
          await _participantsCollection
              .where('bib_number', isEqualTo: participantDTO.bibNumber)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        return 'Duplicate';
      }

      await Future.wait([
        _participantsCollection
            .doc(participantDTO.id)
            .set(participantDTO.toJson()),
        _checkPointLogCollection
            .doc(checpointlogDTO.id)
            .set(checpointlogDTO.toJson()),
      ]);

      return 'Success';
    } catch (e) {
      return 'Error';
    }
  }

  Future<String> deleteParticipant(String paticipantID) async {
    try {
      await Future.wait([
        _participantsCollection.doc(paticipantID).delete(),
        _checkPointLogCollection.doc(paticipantID).delete(),
      ]);
      return 'Success';
    } catch (e) {
      return 'Error';
    }
  }

  Future<void> cardClick(String participantID) async {
    final raceDoc = await _raceCollection.doc('pxs4oGoSCo46kvMk0lNN').get();
    final raceStartTimestamp = raceDoc.get('start_time') as Timestamp;
    final raceStartTime = raceStartTimestamp.toDate();

    final now = DateTime.now();
    final duration = now.difference(raceStartTime);

    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    final milliseconds = duration.inMilliseconds % 1000;
    final formattedTime =
        "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}:${milliseconds.toString().padLeft(3, '0')}";
    await _checkPointLogCollection.doc(participantID).update({
      'time_logged': now,
      'updated_at': now,
      'duration': formattedTime,
    });
  }

  Future<void> cardClickRemove(String participantID) async {
    await _checkPointLogCollection.doc(participantID).update({
      'time_logged': null,
      'updated_at': DateTime.now(),
      'duration': null,
    });
  }
}
