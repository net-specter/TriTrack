import 'package:flutter/material.dart';
import 'package:frontend/core/services/participant_service.dart';
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

  // Stream<List<CombinedParticipantDto>> getCombinedParticipants() {
  //   return _participantService.getCombinedParticipants();
  // }

  Stream<List<Participant>> getParticipantsBySegmentNotNull(String segment) {
    return _participantService.getParticipantsBySegmentNotNull(segment);
  }

  Stream<List<Participant>> getParticipantBySegment(String segmentType) {
    return _participantService.getParticipantBySegment(segmentType);
  }

  Future<String> replaceParticipant(Participant participant) {
    return _participantService.replaceParticipant(participant);
  }

  Future<String> checkDuplicateBibNumber(Participant participant) {
    return _participantService.checkDuplicateBibNumber(participant);
  }

  Future<String> deleteParticipant(Participant participant) {
    return _participantService.deleteParticipant(participant);
  }

  Future<void> cardClickRunning(String participantId) async {
    return await _participantService.cardClickRunning(participantId);
  }

  Future<void> cardClickSwimming(String participantId) async {
    return await _participantService.cardClickSwimming(participantId);
  }

  Future<void> cardClickCycling(String participantId) async {
    return await _participantService.cardClickCycling(participantId);
  }

  Future<void> cardClickRemoveCycling(String participantId) async {
    return await _participantService.cardClickRemoveCycling(participantId);
  }

  Future<void> cardClickRemoveRunning(String participantId) async {
    return await _participantService.cardClickRemoveRunning(participantId);
  }

  Future<void> cardClickRemoveSwimming(String participantId) async {
    return await _participantService.cardClickRemoveSwimming(participantId);
  }

  Future<String> inputParticipantCycling(String bibNumber) async {
    return await _participantService.inputParticipantCycling(bibNumber);
  }

  Future<String> inputParticipantRunning(String bibNumber) async {
    return await _participantService.inputParticipantRunning(bibNumber);
  }

  Future<String> inputParticipantSwimming(String bibNumber) async {
    return await _participantService.inputParticipantSwimming(bibNumber);
  }
}
