import 'dart:async';

import 'package:test_api/test_api.dart';

void main() {
  group("これがないとチェックできない物がある必須系", () {
    test("例外が飛んだことを確かめるthrowsA", () {
      // テストする対象。今回は引数に負数を入れると例外を飛ばす関数
      final shouldPositive = (int val) {
        if (val < 0) throw Exception("It should be positive!!!");
      };

      // throwsAは引数なしの関数しかmatch対象にできないので、
      // 基本的に第一引数にはラムダ式を入れることになる。
      expect(() {shouldPositive(-1);}, throwsA(anything));

      // エラーで終了するFutureの確認もthrowsAを使う。
      final task = Future.error(Exception("Future error"));
      expect(task, throwsA(anything));

      //ただ例外が飛ぶだけを確認するなら、throwsExceptionを使う手もある
      // expect(task, throwsException);
    });
  });

  group("条件をお手軽に書ける便利系", () {
    test("Futureの結果を待ち受けるcompletion", () {
      final task = Future.delayed(Duration(seconds: 1), () => "1秒後に値が返ります");
      // awaitで値を待ち受ける必要がなくなるので便利
      expect(task, completion("1秒後に値が返ります"));
    });

    test("比較系を自然言語っぽく読めるようにしてくれる大なり小なり系", () {
      expect(42, greaterThan(1));
      expect(42, greaterThanOrEqualTo(42));
      expect(42, lessThan(50));
      expect(42, lessThanOrEqualTo(42));

      // 実は[Duration]や[Size]など比較演算子をオーバーライドしているものなら比較できる
      expect(Duration(seconds: 3), lessThan(Duration(minutes: 1)));
    });

    test("期待した型か確認するis系", () {
      // 中身は[TypeMatcher]なので直に[TypeMatcher]を使ってもいいし、
      // [TypeMatcher]も is 演算子で型を確かめているだけなので is で代替してもいい。
      expect(FormatException(), isException);
      expect([1, 2, 3, 4, 5], isList);
      expect({"hoge": "fuga", 1234: 5678}, isMap);
      var actual;
      expect(actual, isNull);
    });

    test("変数や値が期待した状態か確認するis系", () {
      String value;
      expect(value, isNull);

      value = "non-nullであることも確認できる";
      expect(value, isNotNull);

      List<int> list = [];
      expect(list, isEmpty);

      Map<String, String> map = {
        "is(Not)Emptyメソッドを持っているクラスになら"
            : "is(Not)Empty matcherを使用できます"
      };
      expect(map, isNotEmpty);

      double nan = double.nan;
      expect(nan, isNaN);
    });

    test("matcherの条件を反転させるisNot", () {
      String value;
      expect(value, isNot(isList));

//      final task = Future.value("どうやらAsyncMatcherの子クラスの結果は反転できない模様");
//      expect(task, isNot(throwsA(anything)));
    });

    test("文字列の状態を判定する系", () {
      // 含まれていることを確かめる
      expect("わたしたちはここにいます", contains("わたし"));

      // 指定文字列で始まっていることを確かめる
      expect("ここには夢がちゃんとある", startsWith("ここ"));

      // 指定文字列で終わっていることを確かめる
      expect("フレンドなら ともだちでしょ", endsWith("でしょ"));

      // 正規表現にマッチするか確かめる
      expect("だいすき ありがとっ", matches(RegExp("^だ.*っ\$")));
    });
  });
}
