import 'package:flutter/material.dart';

import '../providers/game_provider.dart';
import '../widgets/game_card.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key, required this.provider});
  final GameProvider provider;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: provider,
      builder: (context, _) {
        final favorites = provider.favorites;
        return Scaffold(
          appBar: AppBar(title: const Text('My Favorites')),
          body: favorites.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.favorite_border, size: 60, color: Theme.of(context).colorScheme.primary),
                        const SizedBox(height: 12),
                        Text('No favorites yet', style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 6),
                        const Text('Tap the heart on a giveaway card to save it here.', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 260,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.78,
                  ),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final game = favorites[index];
                    return GameCard(
                      game: game,
                      isFavorite: true,
                      onFavoriteTap: () => provider.toggleFavorite(game),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => DetailScreen(game: game)),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
