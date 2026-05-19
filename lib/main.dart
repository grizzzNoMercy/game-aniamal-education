import 'package:flutter/material.dart';
import 'package:game_edukasi/core/theme/app_theme.dart';
import 'package:game_edukasi/screens/home/home_screen.dart';

void main() {
  runApp(const AnimalExplorerApp());
}

class AnimalExplorerApp extends StatelessWidget {
  const AnimalExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animal Explorer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
