import 'package:flutter/material.dart';

import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.themeProvider});
  final ThemeProvider themeProvider;

  static const List<_ThemeChoice> _colors = [
    _ThemeChoice('Purple', Color(0xFF6750A4)),
    _ThemeChoice('Blue', Color(0xFF1565C0)),
    _ThemeChoice('Green', Color(0xFF2E7D32)),
    _ThemeChoice('Orange', Color(0xFFEF6C00)),
    _ThemeChoice('Pink', Color(0xFFC2185B)),
    _ThemeChoice('Teal', Color(0xFF00897B)),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeProvider,
      builder: (context, _) {
        final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(title: const Text('Settings')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('Appearance', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Card(
                child: SwitchListTile.adaptive(
                  secondary: Icon(themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
                  title: const Text('Dark mode'),
                  subtitle: Text(themeProvider.isDarkMode ? 'Dark appearance is enabled' : 'Light appearance is enabled'),
                  value: themeProvider.isDarkMode,
                  onChanged: themeProvider.setDarkMode,
                ),
              ),
              const SizedBox(height: 24),
              Text('Color theme', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('Choose the main accent color for buttons, icons and highlights.', style: theme.textTheme.bodyMedium),
              const SizedBox(height: 14),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Wrap(
                    spacing: 18,
                    runSpacing: 18,
                    children: _colors.map((choice) {
                      final selected = themeProvider.seedColor.toARGB32() == choice.color.toARGB32();
                      return InkWell(
                        borderRadius: BorderRadius.circular(40),
                        onTap: () => themeProvider.setSeedColor(choice.color),
                        child: SizedBox(
                          width: 76,
                          child: Column(
                            children: [
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: choice.color,
                                  shape: BoxShape.circle,
                                  border: selected ? Border.all(color: theme.colorScheme.onSurface, width: 3) : null,
                                ),
                                child: selected ? const Icon(Icons.check, color: Colors.white) : null,
                              ),
                              const SizedBox(height: 6),
                              Text(choice.name, style: theme.textTheme.labelMedium),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text('About', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.sports_esports),
                  title: Text('Game Giveaway Finder'),
                  subtitle: Text('A student Flutter assignment using the GamerPower API.'),
                ),
              ),
              const SizedBox(height: 8),
              const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
                leading: Icon(Icons.info_outline),
                title: Text('Data source'),
                subtitle: Text('www.gamerpower.com/api/giveaways'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ThemeChoice {
  const _ThemeChoice(this.name, this.color);
  final String name;
  final Color color;
}
