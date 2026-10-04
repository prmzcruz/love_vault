import 'package:flutter_test/flutter_test.dart';
import 'package:surprize/main.dart';

void main() {
  testWidgets('LoveVaultApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const LoveVaultApp());
    expect(find.textContaining('LoveVault'), findsWidgets);
  });
}
