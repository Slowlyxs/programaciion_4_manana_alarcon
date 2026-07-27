import 'package:flutter_test/flutter_test.dart';
import 'package:mp_08_material3/main.dart';

void main() {
  testWidgets('Muestra MP 08 en una sola pantalla', (tester) async {
    await tester.pumpWidget(const AppAeropuertos());
    expect(find.text('MP 08 · Material 3 aeroportuario'), findsOneWidget);
    expect(find.text('Material 3 en una sola pantalla'), findsOneWidget);
  });
}
