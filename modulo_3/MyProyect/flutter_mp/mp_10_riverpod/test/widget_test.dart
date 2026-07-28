import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp_10_riverpod/main.dart';

void main() {
  testWidgets('Muestra MP 10 en una sola pantalla', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: AppAeropuertos()));
    expect(find.text('MP 10 · Riverpod aeroportuario'), findsOneWidget);
    expect(find.text('Riverpod en una sola pantalla'), findsOneWidget);
  });
}
