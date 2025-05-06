import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/providers/participant_provider.dart';
import 'package:frontend/core/services/participant_service.dart';
import 'package:frontend/data/repositories/participant_repository.dart';
import './core/providers/race_provider.dart';
import './core/services/race_service.dart';
import './core/theme/colors.dart';
import './core/theme/text_styles.dart';
import './core/widgets/errors/no_connection.dart';
import './data/repositories/race_repository.dart';
import './features/Navigation_Bar/bottom_bar.dart';
import 'package:provider/provider.dart';
import './core/theme/app_theme.dart';
import './data/firebase_options.dart';
import 'app/router.dart';

main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => RaceService(RaceRepository())),
        ChangeNotifierProvider(
          create: (context) => RaceProvider(context.read<RaceService>()),
        ),
        Provider(create: (_) => ParticipantService(ParticipantRepository())),
        ChangeNotifierProvider(
          create:
              (context) =>
                  ParticipantProvider(context.read<ParticipantService>()),
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

  int _currentIndex = 1;

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
      body: pages[_currentIndex],
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
