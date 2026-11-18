import 'package:flutter_test/flutter_test.dart';
import 'package:gamerpower_giveaways/main.dart';

void main() {
  testWidgets('Game Giveaway Finder app starts',
      (WidgetTester tester) async {
    await tester.pumpWidget(const GameGiveawayApp());

    expect(find.byType(GameGiveawayApp), findsOneWidget);
  });
}