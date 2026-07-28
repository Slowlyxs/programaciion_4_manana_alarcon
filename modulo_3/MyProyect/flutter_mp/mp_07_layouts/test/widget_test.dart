import 'package:flutter_test/flutter_test.dart';
import 'package:mp_07_layouts/main.dart';

void main() {
  testWidgets('Muestra el menú de layouts aeroportuarios', (tester) async {
    await tester.pumpWidget(const Mp07AeropuertosApp());

    expect(find.text('MP 07 · Layouts aeroportuarios'), findsOneWidget);
    expect(find.text('Container'), findsOneWidget);
    expect(find.text('Column'), findsOneWidget);
    expect(find.text('Row y Expanded'), findsOneWidget);
  });
}
