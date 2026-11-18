import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/game_giveaway.dart';

class GamerPowerApi {
  GamerPowerApi({http.Client? client}) : _client = client ?? http.Client();

  static final Uri giveawaysUri =
      Uri.parse('https://www.gamerpower.com/api/giveaways');

  final http.Client _client;

  Future<List<GameGiveaway>> fetchGiveaways() async {
    final response = await _client
        .get(
          giveawaysUri,
          headers: const {'Accept': 'application/json'},
        )
        .timeout(const Duration(seconds: 25));

    if (response.statusCode != 200) {
      throw Exception('API error: HTTP ${response.statusCode}');
    }

    final dynamic decoded = jsonDecode(utf8.decode(response.bodyBytes));
    if (decoded is! List) {
      throw const FormatException('Unexpected API response. Expected a JSON list.');
    }

    return decoded
        .whereType<Map<String, dynamic>>()
        .map(GameGiveaway.fromJson)
        .toList();
  }

  void close() => _client.close();
}
