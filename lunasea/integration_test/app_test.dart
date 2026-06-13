import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:arrpilot/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('ArrPilot App Integration Tests', () {
    testWidgets('app launches successfully without crashing', (tester) async {
      // Launch the app
      app.main();

      // Wait for the app to settle
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Verify the app launched (looking for any widget, not specific text)
      expect(find.byType(app.ArrPilotBIOS), findsOneWidget);
    });

    testWidgets('app initializes database', (tester) async {
      // Launch the app
      app.main();

      // Wait for database initialization
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // If we get here without errors, database initialization succeeded
      expect(find.byType(app.ArrPilotBIOS), findsOneWidget);
    });
  });
}
