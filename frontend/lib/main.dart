import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './core/providers/race_provider.dart';
import './core/services/race_service.dart';
import './core/theme/colors.dart';
import './core/theme/text_styles.dart';
import './core/widgets/errors/no_connection.dart';
import './data/repositories/race_repository.dart';
import './features/Navigation_Bar/bottom_bar.dart';
import './features/home_page/pages/home.dart';
import 'package:provider/provider.dart';
import './core/theme/app_theme.dart';
import './firebase_options.dart';

main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => RaceService(RaceRepository())),
        ChangeNotifierProvider(
          create: (context) => RaceProvider(context.read<RaceService>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
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
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  void _checkConnectivity() {
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        // ignore: unrelated_type_equality_checks
        isConnected = result != ConnectivityResult.none;
      });
    });
  }

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
    if (!isConnected) {
      return NoConnection();
    }
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
