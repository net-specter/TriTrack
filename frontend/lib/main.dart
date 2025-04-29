import 'package:flutter/material.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/theme/text_styles.dart';
import 'package:frontend/features/add_participant/pages/add_paticipant.dart';
import 'package:frontend/features/home_page/pages/home.dart';

import 'core/theme/app_theme.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TriTrack',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: AddParticipantHome(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TriColors.primary,
        title: Center(
          child: Text(
            'TriTrack',
            style: TriTextStyles.title.copyWith(color: TriColors.white),
          ),
        ),
      ),
      body: HomePage(),
    );
  }
}
