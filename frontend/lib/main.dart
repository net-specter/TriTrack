import 'package:flutter/material.dart';
import 'package:frontend/core/theme/colors.dart';
import 'package:frontend/core/theme/text_styles.dart';
import 'package:frontend/features/home_page/pages/home.dart';
import 'package:frontend/features/Navigation_Bar/bottom_bar.dart';
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const Center(child: Text('Participants Page')),
    const Center(child: Text('Input BIB Page')),
    const Center(child: Text('Leaderboard Page')),
    const Center(child: Text('Notification Page')),
  ];

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
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomBar(
        onIndexChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
