import 'package:cloud_firestore/cloud_firestore.dart';
import '../dto/participant_dto.dart';

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

  // Stream<List<CombinedParticipantDto>> getCombinedParticipants() {
  //   final participantStream = _participantsCollection.snapshots();
  //   final checkpointLogStream = _checkPointLogCollection.snapshots();

  //   return Rx.combineLatest2(participantStream, checkpointLogStream, (
  //     QuerySnapshot participantSnapshot,
  //     QuerySnapshot checkpointSnapshot,
  //   ) {
  //     final checkpointMap = {
  //       for (var doc in checkpointSnapshot.docs)
  //         doc.id: CheckPointLogDto.fromJson(
  //           doc.id,
  //           doc.data() as Map<String, dynamic>,
  //         ),
  //     };

  //     final combinedList =
  //         participantSnapshot.docs.map((doc) {
  //             final participant = ParticipantDto.fromJson(
  //               doc.id,
  //               doc.data() as Map<String, dynamic>,
  //             );

  //             final checkpoint =
  //                 checkpointMap[doc.id] ?? CheckPointLogDto.empty(doc.id);

  //             return CombinedParticipantDto(
  //               participant: participant,
  //               checkpointLog: checkpoint,
  //             );
  //           }).toList()
  //           ..sort(
  //             (a, b) =>
  //                 a.participant.bibNumber.compareTo(b.participant.bibNumber),
  //           );

  //     return combinedList;
  //   });
  // }

  Stream<List<ParticipantDto>> getParticipantsBySegmentNotNull(String segment) {
    return _participantsCollection
        .where('${segment}_time', isNotEqualTo: null)
        .orderBy('${segment}_time', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                if (data['${segment}_time'] != null) {
                  return ParticipantDto.fromJson(doc.id, data);
                }
                return null;
              })
              .where((participant) => participant != null)
              .cast<ParticipantDto>()
              .toList();
        });
  }

  Stream<List<ParticipantDto>> getParticipantBySegment(String segmentType) {
    try {
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
    } catch (e) {
      // ignore: avoid_print
      print("Error fetching participants for segment $segmentType: $e");
      return const Stream.empty();
    }
  }

  Future<String> checkDuplicateBibNumber(ParticipantDto participantDTO) async {
    try {
      final querySnapshot =
          await _participantsCollection
              .where('bib_number', isEqualTo: participantDTO.bibNumber)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        return 'Duplicate';
      } else {
        return await addParticipant(participantDTO);
      }
    } catch (e) {
      return 'Error';
    }
  }

  Future<String> replaceParticipant(ParticipantDto participantDTO) async {
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
        ]);
      }

      return 'Success';
    } catch (e) {
      return 'Error';
    }
  }

  Future<String> addParticipant(ParticipantDto participantDTO) async {
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

  Future<void> _updateSegmentTime(
    String participantID,
    String segmentFieldPrefix,
  ) async {
    final raceDoc = await _raceCollection.doc('pxs4oGoSCo46kvMk0lNN').get();
    if (!raceDoc.exists) {
      throw Exception("Race document not found.");
    }

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

    await _participantsCollection.doc(participantID).update({
      '${segmentFieldPrefix}_time': now,
      '${segmentFieldPrefix}_duration': formattedTime,
      'updated_at': now,
    });
  }

  Future<void> cardClickSwimming(String participantID) async {
    await _updateSegmentTime(participantID, 'swimming');
  }

  Future<void> cardClickRunning(String participantID) async {
    await _updateSegmentTime(participantID, 'running');
  }

  Future<void> cardClickCycling(String participantID) async {
    await _updateSegmentTime(participantID, 'cycling');
  }

  Future<void> _cardClickRemove(
    String participantID,
    String segmentFieldPrefix,
  ) async {
    await _participantsCollection.doc(participantID).update({
      '${segmentFieldPrefix}_time': null,
      '${segmentFieldPrefix}_duration': null,
      'updated_at': DateTime.now(),
    });
  }

  Future<void> cardClickRemoveSwimming(String participantID) async {
    await _cardClickRemove(participantID, 'swimming');
  }

  Future<void> cardClickRemoveRunning(String participantID) async {
    await _cardClickRemove(participantID, 'running');
  }

  Future<void> cardClickRemoveCycling(String participantID) async {
    await _cardClickRemove(participantID, 'cycling');
  }

  Future<String> _inputParticipant(
    String bibNumber,
    String segmentFieldPrefix,
  ) async {
    try {
      final querySnapshot =
          await _participantsCollection
              .where('bib_number', isEqualTo: double.parse(bibNumber))
              .get();

      if (querySnapshot.docs.isEmpty) {
        return 'This BIB Number is not registered.';
      }
      final participantDoc = querySnapshot.docs.first;
      final participantID = participantDoc.id;
      final raceDoc = await _raceCollection.doc('pxs4oGoSCo46kvMk0lNN').get();
      if (!raceDoc.exists) {
        throw Exception("Race document not found.");
      }

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
      await _participantsCollection.doc(participantID).update({
        '${segmentFieldPrefix}_time': now,
        '${segmentFieldPrefix}_duration': formattedTime,
        'updated_at': now,
      });

      return 'Success';
    } catch (e) {
      print("Error in _inputParticipant: $e");
      return 'Error';
    }
  }

  Future<String> inputParticipantSwimming(String bibNumber) async {
    return await _inputParticipant(bibNumber, 'swimming');
  }

  Future<String> inputParticipantRunning(String bibNumber) async {
    return await _inputParticipant(bibNumber, 'running');
  }

  Future<String> inputParticipantCycling(String bibNumber) async {
    return await _inputParticipant(bibNumber, 'cycling');
  }
}
