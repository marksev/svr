import 'package:flutter_test/flutter_test.dart';
import 'package:simple_flutter_app/main.dart';

void main() {
  testWidgets('App displays record button', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Start Recording'), findsOneWidget);
  });
}
