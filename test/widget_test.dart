import 'package:flutter_test/flutter_test.dart';
import 'package:simple_flutter_app/main.dart';

void main() {
  testWidgets('Game displays initial score', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Score: 0'), findsOneWidget);
  });
}
