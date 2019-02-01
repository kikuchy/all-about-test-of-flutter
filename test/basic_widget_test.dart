import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fluttertests/main.dart';

void main() {
  testWidgets('カウンター数値が増えることを確認する', (WidgetTester tester) async {
    // MyAppを仮想画面に展開してフレームを進める
    await tester.pumpWidget(MyApp());

    // カウンターが0であることを確認する
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // '+' アイコンのボタンをタップしてフレームを進める
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // カウンター数値が増えていることを確認する
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
