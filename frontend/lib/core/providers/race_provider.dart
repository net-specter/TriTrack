import 'package:flutter/foundation.dart';
import '../models/race.dart';
import '../services/race_service.dart';

class RaceProvider with ChangeNotifier {
  final RaceService _raceService;

  List<Race> _races = [];
  List<Race> get races => _races;

  RaceProvider(this._raceService) {
    _listenToRaces();
  }

  void _listenToRaces() {
    _raceService.getRaces().listen((raceList) {
      _races = raceList;
      notifyListeners();
    });
  }

  Future<void> addRace(Race race) async {
    await _raceService.addRace(race);
    notifyListeners();
  }

  Future<void> startRace(String raceID) async {
    await _raceService.startTime(raceID);
    notifyListeners();
  }

  Future<void> endRace(String raceID) async {
    await _raceService.endTime(raceID);
    notifyListeners();
  }
}
