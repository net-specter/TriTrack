import 'package:flutter/material.dart';

import '../features/home_page/pages/home.dart';
import '../features/input_bib/pages/input_bib.dart';

final List<Widget> pages = [
  const HomePage(),
  const Center(child: Text('Participants Page')),
  const InputBib(),
  const Center(child: Text('Leaderboard Page')),
  const Center(child: Text('Notification Page')),
];
