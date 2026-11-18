import 'package:flutter/foundation.dart';

import '../data/gamerpower_api.dart';
import '../models/game_giveaway.dart';

class GameProvider extends ChangeNotifier {
  GameProvider({GamerPowerApi? api}) : _api = api ?? GamerPowerApi();

  final GamerPowerApi _api;
  List<GameGiveaway> games = [];
  final Set<int> _favoriteIds = {};
  bool isLoading = false;
  String? errorMessage;

  List<GameGiveaway> get favorites =>
      games.where((game) => _favoriteIds.contains(game.id)).toList();

  bool isFavorite(GameGiveaway game) => _favoriteIds.contains(game.id);

  void toggleFavorite(GameGiveaway game) {
    if (!_favoriteIds.add(game.id)) {
      _favoriteIds.remove(game.id);
    }
    notifyListeners();
  }

  Future<void> loadGames() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      games = await _api.fetchGiveaways();
    } catch (error) {
      errorMessage = error.toString().replaceFirst('Exception: ', '');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _api.close();
    super.dispose();
  }
}
