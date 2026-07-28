import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp_11_gorouter/main.dart';

void main() {
  testWidgets('Muestra MP 11 en una sola pantalla', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: AppAeropuertos()));
    await tester.pump();
    expect(find.text('MP 11 · GoRouter aeroportuario'), findsOneWidget);
    expect(find.text('GoRouter en una sola pantalla'), findsOneWidget);
  });
}
