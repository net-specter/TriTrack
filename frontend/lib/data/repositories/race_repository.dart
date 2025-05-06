import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/dto/race_dto.dart';

class RaceRepository {
  final CollectionReference _racesCollection = FirebaseFirestore.instance
      .collection('race');

  Stream<List<RaceDTO>> getRaces() {
    return _racesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return RaceDTO.fromFirestore(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );
      }).toList();
    });
  }

  Future<void> addRace(RaceDTO raceDTO) async {
    await _racesCollection.doc(raceDTO.id).set(raceDTO.toFirestore());
  }

  Future<void> startTime(String raceID) async {
    await _racesCollection.doc(raceID).update({
      'start_time': Timestamp.now(),
      'status': 'in_progress',
    });
  }

  Future<void> endTime(String raceID) async {
    await _racesCollection.doc(raceID).update({
      'end_time': Timestamp.now(),
      'status': 'finished',
    });
  }
}
