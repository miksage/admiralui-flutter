import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

// ignore: avoid_relative_lib_imports
import '../example/lib/main.dart';

Future<void> main() async {
  testWidgets('description', (WidgetTester tester) async {});
  testGoldens('app', (WidgetTester tester) async {
    // TODO: - Вернуть когда починим главную
    // await tester.pumpWidgetBuilder(const MyApp());
    // await multiScreenGolden(tester, 'home_page');
  });
}
