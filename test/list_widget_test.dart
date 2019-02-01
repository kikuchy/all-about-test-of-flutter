import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fluttertests/list.dart';

void main() {
  testWidgets("3の倍数でも5の倍数でもなければ数字が表示される", (tester) async {
    // Textを含んだWidgetはDirectionalityがないと表示できない。
    // そのためDirectionalityを提供するMaterialAppに含んでやる必要がある。
    // Directionalityで直に括ってもいい。
    await tester.pumpWidget(MaterialApp(home: FizzBuzz(1),));
    expect(find.text("1"), findsOneWidget);
  });
  testWidgets("3の倍数だったらFizz", (tester) async {
    await tester.pumpWidget(MaterialApp(home: FizzBuzz(3),));
    expect(find.text("Fizz"), findsOneWidget);
  });
  testWidgets("5の倍数だったらBuzz", (tester) async {
    await tester.pumpWidget(MaterialApp(home: FizzBuzz(5),));
    expect(find.text("Buzz"), findsOneWidget);
  });
  testWidgets("15の倍数だったらFizzBuzz", (tester) async {
    await tester.pumpWidget(MaterialApp(home: FizzBuzz(15),));
    expect(find.text("FizzBuzz"), findsOneWidget);
  });
  testWidgets("リストの中から要素を探し出す", (tester) async {
    // MyApp Widgetを画面に展開してフレームを進める
    await tester.pumpWidget(MyApp());

    // ListViewを探して、中央から上方向に300ドラッグ
    await tester.drag(find.byType(ListView), Offset(0.0, -300.0));

    // 1秒間分フレームを進める
    await tester.pump(Duration(seconds: 1));

    expect(find.text("FizzBuzz"), findsOneWidget);
  });
}