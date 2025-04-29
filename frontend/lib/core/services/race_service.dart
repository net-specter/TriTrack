import 'package:frontend/data/dto/race_dto.dart';
import '../../data/repositories/race_repository.dart';
import '../models/race.dart';

class RaceService {
  final RaceRepository _raceRepository;
  RaceService(this._raceRepository);
  Race _mapDtoToModel(RaceDTO dto) {
    return Race(
      id: dto.id,
      title: dto.title,
      status: dto.status,
      startTime: dto.startTime,
      endTime: dto.endTime,
      createdAt: dto.createdAt,
    );
  }

  Stream<List<Race>> getRaces() {
    return _raceRepository.getRaces().map((dtoList) {
      return dtoList.map(_mapDtoToModel).toList();
    });
  }

  Future<void> addRace(Race race) async {
    final dto = RaceDTO(
      id: race.id,
      title: race.title,
      status: race.status,
      startTime: race.startTime,
      endTime: race.endTime,
      createdAt: race.createdAt,
    );
    await _raceRepository.addRace(dto);
  }

  Future<void> startTime(String raceID) async {
    await _raceRepository.startTime(raceID);
  }

  Future<void> endTime(String raceID) async {
    await _raceRepository.endTime(raceID);
  }
}
