import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// サンプルのWidget
class StubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("AppBarのタイトル"),
        ),
        body: Center(
          child: Row(
            key: Key("Row in Center"),
            children: <Widget>[
              Text("ほげほげ"),
              RaisedButton(
                onPressed: () {},
                child: Icon(Icons.map),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

void main() {
  testWidgets("Widgetの見た目に反映されるものを使ったFinder", (tester) async {
    await tester.pumpWidget(StubApp());

    expect(
        // 表示テキストでWidgetを探す
        find.text("AppBarのタイトル"),
        findsOneWidget);

    expect(
        // 表示アイコンでWidgetを探す
        find.byIcon(Icons.add),
        findsOneWidget);

    // TextやIconを抱えるWidgetを探す場合はwidgetWith系が使える
    expect(find.widgetWithText(Center, "ほげほげ"), findsOneWidget);
    expect(find.widgetWithIcon(RaisedButton, Icons.map), findsOneWidget);
    // ちなみに RaisedButton.icon() ファクトリコンストラクタで返される型はRaisedButtonではなく
    // _RaisedButtonWithIcon というRaisedButtonの子クラスなので、widgetWith系で含まれる探しても見つからない。
  });

  testWidgets("Widgetツリーの情報を使うFinder", (tester) async {
    await tester.pumpWidget(StubApp());

    expect(
        // Widgetの型で探す。
        // 継承先クラスにはマッチしない。
        find.byType(Icon),
        findsWidgets);

    expect(
        // Widgetが所持しているKeyでWidgetを探す。
        // Key（正しくはValueKey）は引数の値が同値であればKey同士も同値とみなすので、
        // 必ずしも同一のインスタンスを用意する必要はない。
        find.byKey(Key("Row in Center")),
        findsOneWidget);

    expect(
        // Widgetツリーの祖先（親Widget）を探す。
        // この例では、 Icons.add アイコンを持つWidgetを子として抱える FAB を探している。
        find.ancestor(
            of: find.byIcon(Icons.add),
            matching: find.byType(FloatingActionButton)),
        findsOneWidget);

    expect(
        // Widgetツリーの子供（子Widget）を探す。
        // この例では、 AppBar を親に持つ Text を探している。
        find.descendant(of: find.byType(AppBar), matching: find.byType(Text)),
        findsOneWidget);

    expect(
        // 条件式でWidgetを探す。
        // descriptionがあると単純に条件式の意味がわかりやすいのと、
        // エラー時にどんなものが見つからなかったのかわかりやすくなる。
        find.byWidgetPredicate(
            (widget) => widget is Scaffold && widget.drawer != null,
            description: "AppBarを持っていないScaffoldを探します"),
        findsOneWidget);
  });

  testWidgets("Elementツリーの情報を使うFinder", (tester) async {
    await tester.pumpWidget(StubApp());

    expect(
        // Widgetが生成するElementタイプで探す。
        // 引数に渡すのは Element の子クラスである必要がある。
        // WidgetとElementの関係については
        // [monoさんの記事](https://medium.com/flutter-jp/dive-into-flutter-4add38741d07)
        // がわかりやすいのでこちらを参照。
        find.byElementType(SingleChildRenderObjectElement),
        findsWidgets);

    expect(
        // 条件式に該当するElementを生成するWidgetを探す。
        // descriptionを書いておくとエラー表示などがわかりやすくなる。
        find.byElementPredicate(
            (element) =>
                element is MultiChildRenderObjectElement &&
                element.size > Size(100, 100),
            description: "サイズが100x100より大きいMultiChildRenderObjectElementを探します"),
        findsWidgets);
  });
}
