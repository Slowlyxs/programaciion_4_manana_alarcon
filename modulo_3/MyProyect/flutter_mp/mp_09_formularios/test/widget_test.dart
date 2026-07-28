import 'package:flutter_test/flutter_test.dart';
import 'package:mp_09_formularios/main.dart';

void main() {
  testWidgets('Muestra MP 09 en una sola pantalla', (tester) async {
    await tester.pumpWidget(const Mp09AeropuertosApp());
    expect(find.text('MP 09 · Formularios aeroportuarios'), findsOneWidget);
    expect(find.text('Formularios en una sola pantalla'), findsOneWidget);
  });
}
