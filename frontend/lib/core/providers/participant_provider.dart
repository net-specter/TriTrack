import 'package:flutter/material.dart';
import 'package:frontend/core/services/participant_service.dart';

import '../../data/dto/participant_dto.dart';
import '../models/participant.dart';

class ParticipantProvider with ChangeNotifier {
  final ParticipantService _participantService;
  ParticipantProvider(this._participantService) {
    _listenToParticipants();
  }
  List<Participant> _participants = [];
  List<Participant> get participants => _participants;

  void _listenToParticipants() {
    _participantService.getParticipants().listen((participantList) {
      _participants = participantList;
      notifyListeners();
    });
  }

  Stream<List<Participant>> getParticipants() {
    return _participantService.getParticipants();
  }

  Stream<List<CombinedParticipantDto>> getCombinedParticipants() {
    return _participantService.getCombinedParticipants();
  }

  Future<String> replaceParticipant(
    Participant participant,
    CheckPointLog checkpointlog,
  ) {
    return _participantService.replaceParticipant(participant, checkpointlog);
  }

  Future<String> checkDuplicateBibNumber(
    Participant participant,
    CheckPointLog checkpointlog,
  ) {
    return _participantService.checkDuplicateBibNumber(
      participant,
      checkpointlog,
    );
  }

  Future<String> deleteParticipant(Participant participant) {
    return _participantService.deleteParticipant(participant);
  }

  Future<void> cardClick(String participantId) async {
    return await _participantService.cardClick(participantId);
  }

  Future<void> cardClickRemove(String participantId) async {
    return await _participantService.cardClickRemove(participantId);
  }
}
