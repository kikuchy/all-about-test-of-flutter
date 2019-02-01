import 'dart:async';

// Dartのテストを記述する際にimportが必要
import 'package:test_api/test_api.dart';

// 通常のDartプログラムとして記述
void main() {
  test("第一引数にテストの説明を記述",
      /* 第二引数にテストケースとして登録する関数を記述します */ () {
    final actual = "処理の結果得られた結果をexpectの第一引数に";
    final matcher = isNot(equals("期待する条件を第二引数に"));
    expect(actual, matcher);
    expect("matcher以外のインスタンスを渡すとequals matcherでラップされるので", "このexpectはfailします");
  });

  test("非同期処理のテストはasync関数を第二引数に渡せば良い", () async {
    final task = Future.delayed(Duration(seconds: 1), () => "1秒後に値が返ります");
    expect(await task, "1秒後に値が返ります");
  });

  test("飛ばしたいテストケースにはskipの設定をします", () {},
      skip: "飛ばす理由を書きましょう。「○○が出来上がらないと実装できないから」とか");

  test("skip関連で言えば", () {
    expect("実はexpect単位でもskipを設定できます", "理由を書いておきましょう",
        skip: "まだここのメソッドだけスタブだから");
  });

  test("タイムアウトも設定できます", () async {
    final task =
        Future.delayed(Duration(seconds: 1), () => "100ms以内に終わらせろとかシビアすぎ");
    expect(await task, "というわけでこのテストはfail");
    // リポジトリ内のテスト全体のタイムアウト設定は dart_test.yaml でできます。
  }, timeout: Timeout(Duration(milliseconds: 100)));

  test("retryで指定回数だけテストの再実行ができます", () {
    expect("不安定なテストは減らすのがベストですが", "そうもいかないときに使う");
  }, retry: 3);

  test("テストケースにはtagを付けられる", () {
    expect("tag付きテストケースは dart_test.yaml の設定で、", "タグ毎にタイムアウトやスキップの設定が可能");
  }, tags: "fail");

  test("tagは複数設定できる", () async {
    final task = Future.delayed(Duration(minutes: 60), () => "こんな激重タスクは実行したくないときとかに");
    expect(await task, "dart_test.yaml の設定でtakes_long_timeタグ付きテストを除外している");
  }, tags: ["fail", "takes_long_time"]);

  group("階層構造を作りたいときはgroup()", () {
    group("いくらでもネストできます", () {
      test("IntelliJのテスト結果表示でも階層的に表示されます", () {
        expect("ほらね", anything);
      });
    });
    group("groupもtest同様にskip可能です", () {}, skip: "まだ何も出来上がってないもので…");
  });
}
