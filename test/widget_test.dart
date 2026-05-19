import 'package:flutter_test/flutter_test.dart';
import 'package:game_edukasi/main.dart';

void main() {
  testWidgets('App landing screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AnimalExplorerApp());

    // Verify that the title Animal Explorer exists.
    expect(find.text('Animal Explorer'), findsOneWidget);
    expect(find.text('Ensiklopedia'), findsOneWidget);
    expect(find.text('Quiz Time!'), findsOneWidget);
  });
}

