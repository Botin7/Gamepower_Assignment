import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/game_giveaway.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.game});

  final GameGiveaway game;

  Future<void> _openGiveaway(BuildContext context) async {
    final url = game.openGiveawayUrl;
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Giveaway link is not available.')),
      );
      return;
    }

    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the giveaway link.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl = game.image.isNotEmpty ? game.image : game.thumbnail;

    return Scaffold(
      appBar: AppBar(title: const Text('Giveaway details')),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Hero(
              tag: 'giveaway-${game.id}',
              child: imageUrl.isEmpty
                  ? Container(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.sports_esports, size: 70),
                    )
                  : Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: const Icon(Icons.sports_esports, size: 70),
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(label: Text(game.type)),
                    Chip(label: Text(game.status)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(game.title, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _InfoRow(icon: Icons.local_offer_outlined, label: 'Original value', value: game.worth),
                _InfoRow(icon: Icons.devices_outlined, label: 'Platforms', value: game.platforms),
                _InfoRow(icon: Icons.event_outlined, label: 'End date', value: game.endDate),
                _InfoRow(icon: Icons.people_outline, label: 'Interested users', value: game.users.toString()),
                const SizedBox(height: 18),
                Text('Description', style: theme.textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(game.description, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 20),
                Text('How to claim', style: theme.textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(game.instructions, style: theme.textTheme.bodyMedium?.copyWith(height: 1.45)),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: game.openGiveawayUrl.isEmpty ? null : () => _openGiveaway(context),
                    icon: const Icon(Icons.open_in_new),
                    label: const Text('Open giveaway website'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 19, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 10),
          SizedBox(width: 112, child: Text(label, style: Theme.of(context).textTheme.bodyMedium)),
          Expanded(child: Text(value, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}
