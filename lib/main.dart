import 'package:flutter/material.dart';

import 'services/time_service.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  TimeService.initialize();

  runApp(const WorldClockApp());
}

class WorldClockApp extends StatelessWidget {
  const WorldClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'World Clock',
      home: const HomeScreen(),

    );
  }
}