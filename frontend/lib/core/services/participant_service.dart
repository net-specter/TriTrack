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

  Stream<List<CombinedParticipantDto>> getCombinedParticipants() {
    return _participantRepository.getCombinedParticipants().asyncMap((dtoList) {
      return dtoList.map((dto) {
        return CombinedParticipantDto(
          participant: dto.participant,
          checkpointLog: CheckPointLogDto(
            id: dto.checkpointLog.id,
            segmentType: dto.checkpointLog.segmentType,
            duration: dto.checkpointLog.duration,
            timeLog: dto.checkpointLog.timeLog,
            createdAt: dto.checkpointLog.createdAt,
            updatedAt: dto.checkpointLog.updatedAt,
          ),
        );
      }).toList();
    });
  }

  Future<String> checkDuplicateBibNumber(
    Participant participant,
    CheckPointLog checkPointLog,
  ) async {
    return await _participantRepository.checkDuplicateBibNumber(
      ParticipantDto(
        id: participant.id,
        name: participant.name,
        bibNumber: participant.bibNumber,
        category: participant.category,
        createdAt: participant.createdAt,
      ),
      CheckPointLogDto(
        id: participant.id,
        segmentType: null,
        timeLog: null,
        createdAt: participant.createdAt,
        updatedAt: participant.createdAt,
      ),
    );
  }

  Future<String> replaceParticipant(
    Participant participant,
    CheckPointLog checkPointLog,
  ) async {
    final participantDTO = ParticipantDto(
      id: participant.id,
      name: participant.name,
      bibNumber: participant.bibNumber,
      category: participant.category,
      createdAt: participant.createdAt,
    );
    final checkpointlogDTO = CheckPointLogDto(
      id: checkPointLog.id,
      segmentType: null,
      timeLog: null,
      createdAt: checkPointLog.createdAt,
      updatedAt: checkPointLog.updatedAt,
    );
    return await _participantRepository.replaceParticipant(
      participantDTO,
      checkpointlogDTO,
    );
  }

  Future<String> addParticipant(
    Participant participant,
    CheckPointLog checkpointlog,
  ) async {
    final participantDTO = ParticipantDto(
      id: participant.id,
      name: participant.name,
      bibNumber: participant.bibNumber,
      category: participant.category,
      createdAt: participant.createdAt,
    );
    final checkpointlogDTO = CheckPointLogDto(
      id: checkpointlog.id,
      segmentType: checkpointlog.segmentType?.name,
      timeLog: checkpointlog.timeLog,
      createdAt: checkpointlog.createdAt,
      updatedAt: checkpointlog.updatedAt,
    );
    return await _participantRepository.addParticipant(
      participantDTO,
      checkpointlogDTO,
    );
  }

  Future<String> deleteParticipant(Participant participant) async {
    return await _participantRepository.deleteParticipant(participant.id);
  }

  Future<void> cardClick(String participantID) async {
    await _participantRepository.cardClick(participantID);
  }

  Future<void> cardClickRemove(String participantID) async {
    await _participantRepository.cardClickRemove(participantID);
  }
}
