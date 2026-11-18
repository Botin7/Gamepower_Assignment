import 'package:flutter/material.dart';

import '../models/game_giveaway.dart';

class GameCard extends StatelessWidget {
  const GameCard({
    super.key,
    required this.game,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
  });

  final GameGiveaway game;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Hero(
                    tag: 'giveaway-${game.id}',
                    child: _GameImage(url: game.thumbnail.isNotEmpty ? game.thumbnail : game.image),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Material(
                    color: theme.colorScheme.surface.withValues(alpha: 0.92),
                    shape: const CircleBorder(),
                    child: IconButton(
                      visualDensity: VisualDensity.compact,
                      tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
                      onPressed: onFavoriteTap,
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? theme.colorScheme.error : theme.colorScheme.onSurface,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 9, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            game.type,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.circle, size: 4),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            game.worth,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelSmall,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      game.platforms,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GameImage extends StatelessWidget {
  const _GameImage({required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) return const _ImagePlaceholder();
return Image.network(
  url,
  fit: BoxFit.cover,

  // Fix cross-origin images on Flutter Web
  webHtmlElementStrategy:
      WebHtmlElementStrategy.fallback,

  errorBuilder: (context, error, stackTrace) {
    debugPrint('Image loading error: $error');
    debugPrint('Image URL: $url');

    return const _ImagePlaceholder();
  },

  loadingBuilder: (context, child, progress) {
    if (progress == null) return child;

    return const _ImagePlaceholder(
      showLoading: true,
    );
  },
);
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({this.showLoading = false});
  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      alignment: Alignment.center,
      child: showLoading
          ? const CircularProgressIndicator(strokeWidth: 2)
          : Icon(Icons.sports_esports, size: 42, color: Theme.of(context).colorScheme.onSurfaceVariant),
    );
  }
}
