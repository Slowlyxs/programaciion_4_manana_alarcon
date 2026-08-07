import 'package:flutter_test/flutter_test.dart';
import 'package:mp_12_api/main.dart';

void main() {
  testWidgets('Muestra MP 12 en una sola pantalla', (tester) async {
    await tester.pumpWidget(const AppHttp());
    await tester.pump();
    expect(find.text('MP 12 · API aeroportuaria'), findsOneWidget);
    expect(find.text('Consumo de API en una sola pantalla'), findsOneWidget);
  });
}
