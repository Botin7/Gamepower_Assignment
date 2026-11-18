class GameGiveaway {
  const GameGiveaway({
    required this.id,
    required this.title,
    required this.worth,
    required this.thumbnail,
    required this.image,
    required this.description,
    required this.instructions,
    required this.type,
    required this.platforms,
    required this.endDate,
    required this.openGiveawayUrl,
    required this.status,
    required this.users,
  });

  final int id;
  final String title;
  final String worth;
  final String thumbnail;
  final String image;
  final String description;
  final String instructions;
  final String type;
  final String platforms;
  final String endDate;
  final String openGiveawayUrl;
  final String status;
  final int users;

  factory GameGiveaway.fromJson(Map<String, dynamic> json) {
    return GameGiveaway(
      id: _toInt(json['id']),
      title: _toText(json['title'], fallback: 'Untitled giveaway'),
      worth: _toText(json['worth'], fallback: 'Not specified'),
      thumbnail: _toText(json['thumbnail']),
      image: _toText(json['image']),
      description: _toText(json['description'], fallback: 'No description available.'),
      instructions: _toText(json['instructions'], fallback: 'Visit the giveaway page for instructions.'),
      type: _toText(json['type'], fallback: 'Giveaway'),
      platforms: _toText(json['platforms'], fallback: 'Platform not specified'),
      endDate: _toText(json['end_date'], fallback: 'Not specified'),
      openGiveawayUrl: _toText(
        json['open_giveaway_url'] ?? json['open_giveaway'] ?? json['gamerpower_url'],
      ),
      status: _toText(json['status'], fallback: 'Unknown'),
      users: _toInt(json['users']),
    );
  }

  static String _toText(dynamic value, {String fallback = ''}) {
    if (value == null) return fallback;
    final text = value.toString().trim();
    if (text.isEmpty || text.toLowerCase() == 'n/a') return fallback;
    return text;
  }

  static int _toInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
