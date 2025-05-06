import 'package:frontend/core/models/participant.dart';
import 'package:frontend/data/repositories/participant_repository.dart';

import '../../data/dto/participant_dto.dart';

class ParticipantService {
  final ParticipantRepository _participantRepository;
  ParticipantService(this._participantRepository);

  Participant _mapDtoToModel(ParticipantDto dto) {
    return Participant(
      id: dto.id,
      name: dto.name,
      bibNumber: dto.bibNumber,
      category: dto.category,
    );
  }

  Stream<List<Participant>> getParticipants() {
    return _participantRepository.getParticipants().map((dtoList) {
      return dtoList.map(_mapDtoToModel).toList();
    });
  }

  // Stream<List<CombinedParticipantDto>> getCombinedParticipants() {
  //   return _participantRepository.getCombinedParticipants().asyncMap((dtoList) {
  //     return dtoList.map((dto) {
  //       return CombinedParticipantDto(
  //         participant: dto.participant,
  //         checkpointLog: CheckPointLogDto(
  //           id: dto.checkpointLog.id,
  //           segmentType: dto.checkpointLog.segmentType,
  //           duration: dto.checkpointLog.duration,
  //           timeLog: dto.checkpointLog.timeLog,
  //           createdAt: dto.checkpointLog.createdAt,
  //           updatedAt: dto.checkpointLog.updatedAt,
  //         ),
  //       );
  //     }).toList();
  //   });
  // }
  Stream<List<Participant>> getParticipantBySegment(String segmentType) {
    return _participantRepository.getParticipantBySegment(segmentType).map((
      dtoList,
    ) {
      return dtoList.map((dto) {
        return Participant(
          id: dto.id,
          name: dto.name,
          bibNumber: dto.bibNumber,
          category: dto.category,
          swimmingTime: dto.swimmingTime,
          swimmingDuration: dto.swimmingDuration,
          cyclingTime: dto.cyclingTime,
          cyclingDuration: dto.cyclingDuration,
          runningTime: dto.runningTime,
          runningDuration: dto.runningDuration,
        );
      }).toList();
    });
  }

  Stream<List<Participant>> getParticipantsBySegmentNotNull(String segment) {
    return _participantRepository.getParticipantsBySegmentNotNull(segment).map((
      dtoList,
    ) {
      return dtoList.map((dto) {
        return Participant(
          id: dto.id,
          name: dto.name,
          bibNumber: dto.bibNumber,
          category: dto.category,
          swimmingTime: dto.swimmingTime,
          swimmingDuration: dto.swimmingDuration,
          cyclingTime: dto.cyclingTime,
          cyclingDuration: dto.cyclingDuration,
          runningTime: dto.runningTime,
          runningDuration: dto.runningDuration,
        );
      }).toList();
    });
  }

  Future<String> checkDuplicateBibNumber(Participant participant) async {
    return await _participantRepository.checkDuplicateBibNumber(
      ParticipantDto(
        id: participant.id,
        name: participant.name,
        bibNumber: participant.bibNumber,
        category: participant.category,
        createdAt: participant.createdAt,
      ),
    );
  }

  Future<String> replaceParticipant(Participant participant) async {
    final participantDTO = ParticipantDto(
      id: participant.id,
      name: participant.name,
      bibNumber: participant.bibNumber,
      category: participant.category,
      createdAt: participant.createdAt,
    );

    return await _participantRepository.replaceParticipant(participantDTO);
  }

  Future<String> addParticipant(Participant participant) async {
    final participantDTO = ParticipantDto(
      id: participant.id,
      name: participant.name,
      bibNumber: participant.bibNumber,
      category: participant.category,
      createdAt: participant.createdAt,
    );
    return await _participantRepository.addParticipant(participantDTO);
  }

  Future<String> deleteParticipant(Participant participant) async {
    return await _participantRepository.deleteParticipant(participant.id);
  }

  Future<void> cardClickRunning(String participantID) async {
    await _participantRepository.cardClickRunning(participantID);
  }

  Future<void> cardClickCycling(String participantID) async {
    await _participantRepository.cardClickCycling(participantID);
  }

  Future<void> cardClickSwimming(String participantID) async {
    await _participantRepository.cardClickSwimming(participantID);
  }

  Future<void> cardClickRemoveSwimming(String participantID) async {
    await _participantRepository.cardClickRemoveSwimming(participantID);
  }

  Future<void> cardClickRemoveRunning(String participantID) async {
    await _participantRepository.cardClickRemoveRunning(participantID);
  }

  Future<void> cardClickRemoveCycling(String participantID) async {
    await _participantRepository.cardClickRemoveCycling(participantID);
  }

  Future<String> inputParticipantCycling(String bibNumber) async {
    return await _participantRepository.inputParticipantCycling(bibNumber);
  }

  Future<String> inputParticipantRunning(String bibNumber) async {
    return await _participantRepository.inputParticipantRunning(bibNumber);
  }

  Future<String> inputParticipantSwimming(String bibNumber) async {
    return await _participantRepository.inputParticipantSwimming(bibNumber);
  }

  Future<List<Participant>> getParticipantsFinish() {
    return _participantRepository.getParticipantsFinish().then((dtoList) {
      return dtoList.map(_mapDtoToModel).toList();
    });
  }

  Future<List<Participant>> getParticipentSwimmingComplete() {
    return _participantRepository.getParticipentSwimmingComplete().then((
      dtoList,
    ) {
      return dtoList.map(_mapDtoToModel).toList();
    });
  }

  Future<List<Participant>> getParticipentCyclingComplete() {
    return _participantRepository.getParticipentCyclingComplete().then((
      dtoList,
    ) {
      return dtoList.map(_mapDtoToModel).toList();
    });
  }

  Future<List<Participant>> getParticipentRunningComplete() {
    return _participantRepository.getParticipentRunningComplete().then((
      dtoList,
    ) {
      return dtoList.map(_mapDtoToModel).toList();
    });
  }

  Stream<List<Participant>> getParticipantsRank() {
    return _participantRepository.getParticipantsRank().map((dtoList) {
      return dtoList.map((dto) {
        return Participant(
          id: dto.id,
          name: dto.name,
          bibNumber: dto.bibNumber,
          category: dto.category,
          swimmingDuration: dto.swimmingDuration,
          cyclingDuration: dto.cyclingDuration,
          runningDuration: dto.runningDuration,
          rank: dto.rank,
          finalDuration: dto.finalDuration,
          rankValue: dto.rankValue,
        );
      }).toList();
    });
  }
}
