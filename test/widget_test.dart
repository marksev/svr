import 'package:flutter_test/flutter_test.dart';
import 'package:simple_flutter_app/main.dart';

void main() {
  testWidgets('App displays greeting', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Hello, Flutter!'), findsOneWidget);
  });
}
