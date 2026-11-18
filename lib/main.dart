import 'package:flutter/material.dart';

import 'providers/game_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GameGiveawayApp());
}

class GameGiveawayApp extends StatefulWidget {
  const GameGiveawayApp({super.key});

  @override
  State<GameGiveawayApp> createState() => _GameGiveawayAppState();
}

class _GameGiveawayAppState extends State<GameGiveawayApp> {
  late final ThemeProvider _themeProvider;
  late final GameProvider _gameProvider;

  @override
  void initState() {
    super.initState();
    _themeProvider = ThemeProvider();
    _gameProvider = GameProvider();
  }

  @override
  void dispose() {
    _themeProvider.dispose();
    _gameProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _themeProvider,
      builder: (context, _) {
        final seed = _themeProvider.seedColor;
        return MaterialApp(
          title: 'Game Giveaway Finder',
          debugShowCheckedModeBanner: false,
          themeMode: _themeProvider.themeMode,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light),
            scaffoldBackgroundColor: const Color(0xFFF8F7FC),
            appBarTheme: const AppBarTheme(centerTitle: false),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark),
            brightness: Brightness.dark,
          ),
          home: MainScreen(gameProvider: _gameProvider, themeProvider: _themeProvider),
        );
      },
    );
  }
}
