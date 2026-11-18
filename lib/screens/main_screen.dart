import 'package:flutter/material.dart';

import '../providers/game_provider.dart';
import '../providers/theme_provider.dart';
import 'favorites_screen.dart';
import 'game_screen.dart';
import 'settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.gameProvider, required this.themeProvider});

  final GameProvider gameProvider;
  final ThemeProvider themeProvider;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.gameProvider.loadGames();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      GameScreen(provider: widget.gameProvider),
      FavoritesScreen(provider: widget.gameProvider),
      SettingsScreen(themeProvider: widget.themeProvider),
    ];

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.sports_esports_outlined), activeIcon: Icon(Icons.sports_esports), label: 'Games'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), activeIcon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), activeIcon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
