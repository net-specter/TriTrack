import 'package:flutter/material.dart';
import 'package:frontend/features/add_participant/pages/add_participant.dart';

import '../features/home_page/pages/home.dart';
import '../features/input_bib/pages/input_bib.dart';
import '../features/leaderboard/pages/leaderboard.dart';

final List<Widget> pages = [
  const HomePage(),
  const AddParticipant(),
  const InputBib(),
  const Leaderboard(),
  const Center(child: Text('Notification Page')),
];
