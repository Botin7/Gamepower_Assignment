import 'package:flutter/material.dart';

import '../models/game_giveaway.dart';
import '../providers/game_provider.dart';
import '../widgets/game_card.dart';
import 'detail_screen.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.provider});
  final GameProvider provider;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: provider,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Free Game Giveaways'),
            actions: [
              IconButton(
                tooltip: 'Refresh giveaways',
                onPressed: provider.isLoading ? null : provider.loadGames,
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: _buildBody(context, provider.games),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, List<GameGiveaway> games) {
    if (provider.isLoading && games.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null && games.isEmpty) {
      return _MessageState(
        icon: Icons.cloud_off_outlined,
        title: 'Could not load giveaways',
        message: provider.errorMessage!,
        buttonText: 'Try again',
        onPressed: provider.loadGames,
      );
    }

    if (games.isEmpty) {
      return _MessageState(
        icon: Icons.inbox_outlined,
        title: 'No giveaways found',
        message: 'Pull down to refresh and check again.',
        buttonText: 'Refresh',
        onPressed: provider.loadGames,
      );
    }

    return RefreshIndicator(
      onRefresh: provider.loadGames,
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 260,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.78,
        ),
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return GameCard(
            game: game,
            isFavorite: provider.isFavorite(game),
            onFavoriteTap: () => provider.toggleFavorite(game),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => DetailScreen(game: game)),
            ),
          );
        },
      ),
    );
  }
}

class _MessageState extends StatelessWidget {
  const _MessageState({
    required this.icon,
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onPressed,
  });

  final IconData icon;
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 58, color: theme.colorScheme.primary),
            const SizedBox(height: 14),
            Text(title, style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 18),
            FilledButton(onPressed: onPressed, child: Text(buttonText)),
          ],
        ),
      ),
    );
  }
}
